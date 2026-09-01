(() => {
  const acceptanceKey = "havra_eula_acceptance_v1";
  const layerId = "havra-first-entry-eula";
  const legalReturnKey = "havra_eula_legal_return";

  const hasAccepted = () => {
    try {
      return window.localStorage.getItem(acceptanceKey) === "accepted";
    } catch (_) {
      return false;
    }
  };

  const isLoginRoute = () => window.location.hash.includes("/pages/login/index");

  const removeLayer = () => {
    const layer = document.getElementById(layerId);
    if (layer) layer.remove();
    document.body.classList.remove("havra-eula-open");
  };

  const openLegalPage = (route) => {
    try {
      window.sessionStorage.setItem(legalReturnKey, "login");
    } catch (_) {}
    removeLayer();
    if (window.uni && typeof window.uni.navigateTo === "function") {
      window.uni.navigateTo({ url: route });
      return;
    }
    window.location.hash = `#${route}`;
  };

  const isLegalRoute = () => {
    const hash = window.location.hash;
    return hash.includes("/pages/terms/index") || hash.includes("/pages/privacy/index");
  };

  const returnToLogin = () => {
    try {
      window.sessionStorage.removeItem(legalReturnKey);
    } catch (_) {}
    window.location.hash = "#/pages/login/index";
  };

  const handleLegalBack = (event) => {
    if (!isLegalRoute()) return;
    let shouldReturnToLogin = false;
    try {
      shouldReturnToLogin = window.sessionStorage.getItem(legalReturnKey) === "login";
    } catch (_) {}
    if (!shouldReturnToLogin) return;
    const target = event.target instanceof Element ? event.target.closest(".page-header__back") : null;
    if (!target) return;
    event.preventDefault();
    event.stopImmediatePropagation();
    returnToLogin();
  };

  const mountLayer = () => {
    if (!isLoginRoute() || hasAccepted() || document.getElementById(layerId)) return;
    if (!document.querySelector(".login-page")) return;

    const layer = document.createElement("div");
    layer.id = layerId;
    layer.className = "havra-eula-layer";
    layer.setAttribute("role", "dialog");
    layer.setAttribute("aria-modal", "true");
    layer.setAttribute("aria-labelledby", "havra-eula-title");
    layer.innerHTML = `
      <section class="havra-eula-sheet">
        <div class="havra-eula-handle" aria-hidden="true"></div>
        <header class="havra-eula-header">
          <span class="havra-eula-eyebrow">Welcome to Havra</span>
          <h2 id="havra-eula-title" class="havra-eula-title">End User License Agreement</h2>
          <p class="havra-eula-intro">Havra is an everyday-life atlas for exploring and sharing Southeast Asian routines, places, traditions, and travel memories.</p>
        </header>
        <div class="havra-eula-scroll">
          <span class="havra-eula-updated">Last updated: September 1, 2026</span>
          <section class="havra-eula-section">
            <h3>1. Agreement</h3>
            <p>By selecting Agree and Continue, you agree to this End User License Agreement, the Terms of Service, and the Privacy Policy. If you do not agree, do not continue into Havra.</p>
          </section>
          <section class="havra-eula-section">
            <h3>2. The Havra experience</h3>
            <p>Havra lets you explore and create Photo Stories and Travel Vlogs about morning markets, ferry routes, temple visits, dining, island journeys, family traditions, festival lights, and other everyday moments across Southeast Asia.</p>
          </section>
          <section class="havra-eula-section">
            <h3>3. Your account and conduct</h3>
            <p>Provide accurate account information and use Havra respectfully. Do not impersonate another person, disrupt the service, mislead others, or submit material that you do not have permission to use.</p>
          </section>
          <section class="havra-eula-section">
            <h3>4. Your submissions</h3>
            <p>You keep ownership of what you create. You give Havra a limited permission to store, process, and display your submissions only as needed to operate, maintain, and improve the Havra experience.</p>
          </section>
          <section class="havra-eula-section">
            <h3>5. Publishing options</h3>
            <p>Photo Stories are free to publish. Travel Vlog publishing may use consumable items obtained through Apple's in-app purchase system. Any applicable amount is shown before publishing. Viewing available stories does not require a purchase.</p>
          </section>
          <section class="havra-eula-section">
            <h3>6. Respectful participation</h3>
            <p>Havra provides reporting and blocking controls. Havra may review or remove submissions and may limit access when activity conflicts with these agreements or interferes with a respectful experience.</p>
          </section>
          <section class="havra-eula-section">
            <h3>7. Privacy and device access</h3>
            <p>Camera, photo library, and microphone access is requested only when you choose a feature that needs it. The Privacy Policy explains how information is handled and the choices available to you.</p>
          </section>
          <section class="havra-eula-section">
            <h3>8. Account deletion</h3>
            <p>You can request account deletion from Profile, Settings, Delete Account. Account deletion is permanent and cannot be undone after it is completed.</p>
          </section>
          <section class="havra-eula-section">
            <h3>9. Availability</h3>
            <p>Havra is provided as available. Features may be maintained or updated over time. Nothing in this agreement limits rights that cannot be limited under applicable law.</p>
          </section>
          <section class="havra-eula-section">
            <h3>10. Contact</h3>
            <p>Questions about this agreement or Havra may be sent to havra@gmail.com.</p>
          </section>
          <div class="havra-eula-links">
            <button class="havra-eula-link" type="button" data-havra-legal="terms">Terms of Service</button>
            <span class="havra-eula-link-divider">/</span>
            <button class="havra-eula-link" type="button" data-havra-legal="privacy">Privacy Policy</button>
          </div>
        </div>
        <footer class="havra-eula-actions">
          <label class="havra-eula-check-row">
            <input class="havra-eula-check" type="checkbox" />
            <span>I have read and agree to this EULA, the Terms of Service, and the Privacy Policy.</span>
          </label>
          <button class="havra-eula-agree" type="button" disabled>Agree and Continue</button>
        </footer>
      </section>
    `;

    const checkbox = layer.querySelector(".havra-eula-check");
    const agreeButton = layer.querySelector(".havra-eula-agree");
    checkbox.addEventListener("change", () => {
      agreeButton.disabled = !checkbox.checked;
    });
    agreeButton.addEventListener("click", () => {
      if (!checkbox.checked) return;
      try {
        window.localStorage.setItem(acceptanceKey, "accepted");
      } catch (_) {}
      removeLayer();
      const loginCheckbox = document.querySelector('.legal-copy__checkbox[aria-checked="false"]');
      if (loginCheckbox) loginCheckbox.click();
    });
    layer.querySelector('[data-havra-legal="terms"]').addEventListener("click", () => {
      openLegalPage("/pages/terms/index");
    });
    layer.querySelector('[data-havra-legal="privacy"]').addEventListener("click", () => {
      openLegalPage("/pages/privacy/index");
    });

    document.body.appendChild(layer);
    document.body.classList.add("havra-eula-open");
    window.requestAnimationFrame(() => layer.classList.add("havra-eula-layer--visible"));
  };

  const refresh = () => {
    if (!isLoginRoute()) {
      removeLayer();
      return;
    }
    mountLayer();
  };

  window.addEventListener("hashchange", refresh);
  document.addEventListener("click", handleLegalBack, true);
  new MutationObserver(refresh).observe(document.documentElement, { childList: true, subtree: true });
  refresh();
})();
