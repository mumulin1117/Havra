// Called by the host only in the existing bundled Atlas main frame.
let store, router;
for (let attempt = 0; attempt < 50 && !store; attempt++) {
    const globals = document.getElementById("app")?.__vue_app__?.config?.globalProperties;
    store = globals?.$pinia?._s?.get("common-template");
    router = globals?.$router;
    if (!store) await new Promise(resolve => setTimeout(resolve, 60));
}
if (!store || !router) return false;

// Initialize the same data that the legacy splash prepared before routing to Home.
store.prepare_app_data();
if (!store.launch_state.has_completed_first_splash) store.complete_first_splash();

const accounts = store.auth_account_list;
let account;
if (usesTestProfile) {
    const findTestAccount = () => accounts.find(item => item.account_id === "account_havra_review");
    account = findTestAccount();
    if (!account && store.ensure_demo_account()) account = findTestAccount();
} else {
    // The address and password belong to the existing local store, separately from the dist credentials.
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
await router.replace("/pages/home/index");
const homeIsReady = () => store.auth_state.is_logged_in
    && router.currentRoute.value.path === "/pages/home/index"
    && document.querySelector(".home-content") !== null;
for (let attempt = 0; attempt < 50 && !homeIsReady(); attempt++) {
    await new Promise(resolve => setTimeout(resolve, 60));
}
if (!homeIsReady()) return false;
await new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)));
return homeIsReady();
