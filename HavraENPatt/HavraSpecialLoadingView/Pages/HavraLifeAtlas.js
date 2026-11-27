// 由原生容器在包内 Atlas 的主框架执行。
let store, router;
for (let attempt = 0; attempt < 50 && !store; attempt++) {
    const globals = document.getElementById("app")?.__vue_app__?.config?.globalProperties;
    store = globals?.$pinia?._s?.get("common-template");
    router = globals?.$router;
    if (!store) await new Promise(resolve => setTimeout(resolve, 60));
}
if (!store || !router) return false;

const guestPaths = new Set([
    "home", "wall", "search", "tag-library", "post-detail", "video-detail",
    "user-profile", "terms", "privacy"
].map(page => "/pages/" + page + "/index"));

if (guest) {
    // 游客在独立的数据存储中读取公开内容，账号操作统一交给原生登录页。
    const requireAccount = () => {
        window.webkit?.messageHandlers?.havraLifeGuestLogin?.postMessage({action: "login"});
        return false;
    };
    window.havraGuestRoute = location => guestPaths.has(router.resolve(location).path) || requireAccount();
    router.beforeEach(to => guestPaths.has(to.path) || requireAccount());
    store.auth_account_list = [];

    for (const action of [
        "toggle_post_like", "toggle_post_save", "request_follow_user", "cancel_follow_user",
        "ensure_direct_chat_room", "send_chat_message", "create_pet_post", "delete_pet_post",
        "block_user", "submit_report", "update_current_user_profile", "apply_ios_coin_purchase",
        "apply_ios_purchase_restore", "sign_in", "sign_up", "sign_in_with_apple"
    ]) {
        if (typeof store[action] === "function") store[action] = requireAccount;
    }

    // Atlas 的主题面板也能直接写入反应和评论，在它们的监听器之前拦截。
    const accountControls = [
        "like", "save", "topic-save", "create", "share-empty", "detail-like", "card-like",
        "comment-input", "comment-send", "detail-note-input", "detail-note-send",
        "submit-care", "block-person", "care-submit", "care-block"
    ].map(name => "[data-havra-" + name + "]").join(", ");
    const guardAction = event => {
        if (!(event.target instanceof Element) || !event.target.closest(accountControls)) return;
        event.preventDefault();
        event.stopImmediatePropagation();
        requireAccount();
    };
    window.addEventListener("click", guardAction, true);
    window.addEventListener("keydown", event => {
        if (event.key === "Enter") guardAction(event);
    }, true);
} else {
    // 沿用原启动页的数据初始化流程，再进入首页。
    store.prepare_app_data();
    if (!store.launch_state.has_completed_first_splash) store.complete_first_splash();

    const accounts = store.auth_account_list;
    let account;
    if (usesTestProfile) {
        const findTestAccount = () => accounts.find(item => item.account_id === "account_havra_review");
        account = findTestAccount();
        if (!account && store.ensure_demo_account()) account = findTestAccount();
    } else {
        // 此邮箱和密码属于 Atlas 本地数据，与 H5 的登录凭据独立。
        const deleted = store.deleted_account_email_list;
        let sequence = 0;
        let address = localKey + "@havra.invalid";
        while (deleted.includes(address)) {
            sequence++;
            address = localKey + "." + sequence + "@havra.invalid";
        }
        account = accounts.find(item => item.email === address);
        if (!account) {
            const userName = displayName === "@" ? "Havra Member" : displayName;
            store.signup_form = {email: address, password: localPassword, user_name: userName};
            if (!store.sign_up()) return false;
            account = accounts.find(item => item.email === address);
        }
    }
    if (!account) return false;
    if (!store.auth_state.is_logged_in || store.current_user.user_id !== account.user_id) {
        store.login_form = {email: account.email, password: account.password};
        if (!store.sign_in()) return false;
    }
    store.login_form = {email: "", password: ""};
    store.accept_eula();

    if (!window.__havraLifeWatchingAtlasSignOut) {
        window.__havraLifeWatchingAtlasSignOut = true;
        store.$onAction(({name, after}) => {
            if (name !== "sign_out" && name !== "delete_current_account") return;
            after(result => {
                if (name === "delete_current_account" && result !== true) return;
                document.documentElement.style.visibility = "hidden";
                window.webkit.messageHandlers.havraLifeSignOut.postMessage({action: "logout"});
            });
        }, true);
    }
}

await router.replace("/pages/home/index");
const homeIsReady = () => (guest || store.auth_state.is_logged_in)
    && router.currentRoute.value.path === "/pages/home/index"
    && document.querySelector(".home-content") !== null;
for (let attempt = 0; attempt < 50 && !homeIsReady(); attempt++) {
    await new Promise(resolve => setTimeout(resolve, 60));
}
if (!homeIsReady()) return false;
await new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)));
if (!homeIsReady()) return false;

const detailBridge = window.webkit?.messageHandlers?.havraLifeDetailLoading;
const detailStyleID = "havra-detail-loading-style";
if (typeof detailBridge?.postMessage === "function" && !document.getElementById(detailStyleID)) {
    const detailPaths = new Set([
        "search", "post-detail", "video-detail", "user-profile", "user-profile-pending",
        "user-profile-mutual", "connections", "chat-list", "chat-detail", "video-call",
        "tag-library", "library", "my-post-detail", "edit-post", "edit-profile", "coins",
        "purchase-history", "settings", "blocked-users", "report", "terms", "privacy",
        "photo-post", "photo-success", "video-vlog", "video-success"
    ].map(page => "/pages/" + page + "/index"));
    const originalLoading = ".secondary-page-loading, .album-page .skeleton-screen--library";
    const detailStyle = document.createElement("style");
    detailStyle.id = detailStyleID;
    detailStyle.textContent = originalLoading + " { display: none !important; }";
    document.head.append(detailStyle);

    let sequence = 0;
    let activeDetail;
    const notify = (action, detail) => {
        try {
            detailBridge.postMessage({action, id: detail.id});
        } catch {
            // WebView 中断时，由原生超时机制释放加载遮罩。
        }
    };
    const start = fullPath => {
        const detail = {id: String(++sequence), fullPath, started: performance.now()};
        activeDetail = detail;
        notify("start", detail);
        return detail;
    };
    const finish = detail => {
        if (activeDetail !== detail) return;
        activeDetail = undefined;
        notify("finish", detail);
    };
    const detailIsReady = path => {
        const page = Array.from(document.querySelectorAll("uni-page[data-page]")).reverse()
            .find(element => element.dataset.page === path.slice(1) && element.getClientRects().length > 0);
        const content = page?.querySelector("uni-page-body");
        return Boolean(content?.firstElementChild) && !content.querySelector(originalLoading);
    };
    const waitForDetail = async (detail, isReady, isOpen = () => true) => {
        try {
            while (activeDetail === detail && router.currentRoute.value.fullPath === detail.fullPath && isOpen()) {
                const elapsed = performance.now() - detail.started;
                if (elapsed >= 1600 || (elapsed >= 420 && isReady())) return;
                await new Promise(resolve => setTimeout(resolve, 45));
            }
        } finally {
            finish(detail);
        }
    };

    // 只在前往详情时显示加载效果，返回仍沿用 Atlas 的历史栈。
    for (const method of ["push", "replace"]) {
        const navigate = router[method].bind(router);
        router[method] = location => {
            const target = router.resolve(location);
            if ((guest ? !guestPaths.has(target.path) : !store.auth_state.is_logged_in) || !detailPaths.has(target.path) ||
                target.fullPath === router.currentRoute.value.fullPath) return navigate(location);

            const detail = start(target.fullPath);
            try {
                const navigation = navigate(location);
                navigation.then(failure => {
                    if (failure) finish(detail);
                    else void waitForDetail(detail, () => detailIsReady(target.path));
                }, () => finish(detail));
                return navigation;
            } catch (error) {
                finish(detail);
                throw error;
            }
        };
    }
    router.afterEach((to, from, failure) => {
        if (!failure && activeDetail && to.fullPath !== activeDetail.fullPath) finish(activeDetail);
    });

    // Life Atlas 的主题和详情在首页内打开，监听点击补上加载效果。
    window.addEventListener("click", event => {
        const route = router.currentRoute.value;
        const target = event.target;
        if ((!guest && !store.auth_state.is_logged_in) || route.path !== "/pages/home/index" ||
            event.button !== 0 || !(target instanceof Element)) return;
        if (target.closest("[data-havra-like], [data-havra-care]")) return;
        const topic = target.closest(".havra-life-atlas-section .havra-life-card[data-havra-topic]");
        const moment = target.closest(".havra-atlas-overlay .havra-topic-moment-card[data-havra-moment]");
        if (!topic && !moment) return;

        const selector = topic ? ".havra-atlas-overlay .havra-topic-hero" : ".havra-atlas-overlay .havra-moment-main";
        const previous = document.querySelector(selector);
        const detail = start(route.fullPath);
        setTimeout(() => {
            if (activeDetail !== detail) return;
            const panel = document.querySelector(selector);
            if (!panel || panel === previous) {
                finish(detail);
                return;
            }
            void waitForDetail(detail, () => panel.getClientRects().length > 0, () => panel.isConnected);
        }, 0);
    }, true);
}
return true;
