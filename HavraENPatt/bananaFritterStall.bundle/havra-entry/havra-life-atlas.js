(function () {
  "use strict";

  var storeChannel = "pet_one_state";
  var reactionChannel = "havra_atlas_reactions";
  var commentChannel = "havra_atlas_comments";
  var overlayNode = null;
  var careNode = null;
  var activeTopicId = "";
  var activeFilter = "All";
  var activeMomentId = "";
  var installedHistoryDepth = 0;
  var homeWatchArmed = false;
  var topicChipOffset = 0;

  function byClass(name, root) {
    return Array.prototype.slice.call((root || document).querySelectorAll(name));
  }

  function first(name, root) {
    return (root || document).querySelector(name);
  }

  function readJson(key, fallbackValue) {
    try {
      var rawValue = localStorage.getItem(key);
      return rawValue ? JSON.parse(rawValue) : fallbackValue;
    } catch (error) {
      return fallbackValue;
    }
  }

  function writeJson(key, value) {
    try {
      localStorage.setItem(key, JSON.stringify(value));
    } catch (error) {
    }
  }

  function readAppState() {
    return readJson(storeChannel, {});
  }

  function writeAppState(nextState) {
    writeJson(storeChannel, nextState || {});
  }

  function atlasAsset(path) {
    var cleanedPath = String(path || "").replace(/^\.\//, "").replace(/^\/+/, "");
    if (window.__havraAssetUrl) {
      return window.__havraAssetUrl(cleanedPath);
    }
    if (window.location.href.indexOf("havra-runtime://") === 0) {
      return "havra-runtime://app/" + cleanedPath;
    }
    return "./" + cleanedPath;
  }

  function still(name) {
    return atlasAsset("havra-atlas/visual-set/scene-stills/" + name);
  }

  function face(name) {
    return atlasAsset("havra-atlas/visual-set/profile-faces/" + name);
  }

  function symbol(name) {
    return atlasAsset("havra-atlas/visual-set/interface-symbols/" + name);
  }

  function kit(name) {
    return atlasAsset("havra-atlas/publish-kit/" + name);
  }

  function escapeText(value) {
    return String(value == null ? "" : value).replace(/[&<>\"]/g, function (marker) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", "\"": "&quot;" }[marker];
    });
  }

  function makeId(seed) {
    return String(seed || "atlas") + "_" + Date.now().toString(36) + Math.random().toString(36).slice(2, 7);
  }

  var atlasTopics = [
    {
      id: "morning-market",
      title: "Morning Market",
      shortTitle: "Morning\nMarket",
      subtitle: "Breakfast steam, fresh baskets, and first light before the city wakes",
      cardIcon: kit("market-basket-line.svg"),
      cover: still("atlas-morning-market-glow.png"),
      filters: ["All", "Breakfast", "Fruit Stalls", "Coffee Carts", "Street Colors"],
      emptyTitle: "No moments here yet",
      emptyText: "Start this atlas lane with a first morning detail."
    },
    {
      id: "ferry-ride",
      title: "Ferry Ride",
      shortTitle: "Ferry\nRide",
      subtitle: "Golden rails, soft water, and slow crossings between shorelines",
      cardIcon: kit("harbor-vessel.svg"),
      cover: still("atlas-ferry-harbor-gold.png"),
      filters: ["All", "Harbor Route", "Window Seat", "Island View", "Slow Crossing"],
      emptyTitle: "No ferry notes yet",
      emptyText: "Add the first quiet crossing from your harbor day."
    },
    {
      id: "temple-visit",
      title: "Temple Visit",
      shortTitle: "Temple\nVisit",
      subtitle: "Stone gates, incense mornings, and lantern shade",
      cardIcon: kit("temple-pavilion.svg"),
      cover: still("atlas-temple-courtyard-dawn.png"),
      filters: ["All", "Lantern Path", "Courtyard", "Offerings", "Old Streets"],
      emptyTitle: "No temple memories yet",
      emptyText: "Place the first courtyard memory in this lane."
    },
    {
      id: "night-market",
      title: "Night Market",
      shortTitle: "Night\nMarket",
      subtitle: "Amber stalls, dinner aromas, and glowing lanes after dark",
      cardIcon: kit("lantern-lane.svg"),
      cover: still("atlas-night-market-lane.png"),
      filters: ["All", "Food Lane", "Lantern Rows", "Street Snacks", "Evening Walk"],
      emptyTitle: "No night market stories yet",
      emptyText: "Open this evening lane with one small detail."
    },
    {
      id: "island-hop",
      title: "Island Hop",
      shortTitle: "Island\nHop",
      subtitle: "Turquoise coves, small boats, and bright routes between islands",
      cardIcon: kit("island-palm.svg"),
      cover: still("atlas-island-lagoon-route.png"),
      filters: ["All", "Boat Route", "Beach Day", "Blue Water", "Island Trail"],
      emptyTitle: "No island moments yet",
      emptyText: "Add the first coastal note from a bright crossing."
    }
  ];

  var fallbackFaces = {
    user_amy: face("face-bangkok-guide.png"),
    user_mai: face("face-bali-morning.png"),
    user_daniel: face("face-hanoi-reader.png"),
    user_lina: face("face-manila-sunset.png"),
    user_miso: face("face-bangkok-lane.png"),
    user_suri: face("face-penang-craft.png")
  };

  var atlasMoments = [
    {
      id: "post_havra_bangkok_market",
      topicId: "morning-market",
      filter: "Breakfast",
      creatorId: "user_amy",
      fallbackName: "Havra",
      fallbackAvatar: fallbackFaces.user_amy,
      cover: still("atlas-dawn-stall.jpg"),
      title: "First steam on the market lane",
      subtitle: "Breakfast light over baskets and cups",
      body: "Steam lifted from breakfast pots while the first stalls opened. The lane felt awake before the traffic did, full of fruit colors, warm cups, and quiet morning steps.",
      details: [
        [kit("cafe-cup.png"), "Scene", "Breakfast corner"],
        [kit("joy-sun.png"), "Mood", "First light"],
        [symbol("still-collection.svg"), "Memory", "Market opening" ]
      ],
      tags: ["Morning Market", "Coffee Carts", "Street Colors"],
      baseLikes: 42,
      baseSaves: 15
    },
    {
      id: "atlas_morning_fruit_lane",
      topicId: "morning-market",
      filter: "Fruit Stalls",
      creatorId: "user_suri",
      fallbackName: "Suri Lim",
      fallbackAvatar: fallbackFaces.user_suri,
      cover: still("atlas-fruit-row.jpg"),
      title: "Fruit colors before noon",
      subtitle: "Baskets, leaves, and a quiet morning rhythm",
      body: "A small produce corner turned bright before lunch. Mangoes, greens, and woven baskets gave the morning its own gentle pattern.",
      details: [
        [kit("market-basket.png"), "Scene", "Fruit row"],
        [kit("mindful-leaf.png"), "Mood", "Gentle detail"],
        [symbol("still-collection.svg"), "Memory", "A bright market corner"]
      ],
      tags: ["Fruit Stalls", "Morning Market", "Daily Rhythm"],
      baseLikes: 29,
      baseSaves: 8
    },
    {
      id: "atlas_ferry_harbor_window",
      topicId: "ferry-ride",
      filter: "Window Seat",
      creatorId: "user_daniel",
      fallbackName: "Daniel Tran",
      fallbackAvatar: fallbackFaces.user_daniel,
      cover: still("atlas-harbor-crossing.jpg"),
      title: "Golden rail crossing",
      subtitle: "A calm route between soft shorelines",
      body: "The ferry moved through gold water and low island shapes. Everyone seemed to carry a small plan for the day, wrapped in the hush of the crossing.",
      details: [
        [kit("harbor-vessel.svg"), "Scene", "Harbor route"],
        [kit("easy-breeze.png"), "Mood", "Slow crossing"],
        [symbol("saved-ribbon.svg"), "Memory", "Window rail view"]
      ],
      tags: ["Ferry Ride", "Island View", "Harbor Route"],
      baseLikes: 33,
      baseSaves: 10
    },
    {
      id: "post_havra_hoi_an_lanterns",
      topicId: "temple-visit",
      filter: "Lantern Path",
      creatorId: "user_amy",
      fallbackName: "Havra",
      fallbackAvatar: fallbackFaces.user_amy,
      cover: still("atlas-lantern-courtyard.jpg"),
      title: "Courtyard light at sunrise",
      subtitle: "Lantern shade beside carved stone",
      body: "Morning light reached the courtyard slowly. Stone details, hanging lanterns, and quiet footsteps made the visit feel careful and calm.",
      details: [
        [kit("temple-pavilion.svg"), "Scene", "Temple courtyard"],
        [kit("heritage-lantern.png"), "Mood", "Quiet light"],
        [symbol("saved-ribbon.svg"), "Memory", "Lantern shade"]
      ],
      tags: ["Temple Visit", "Lantern Path", "Old Streets"],
      baseLikes: 58,
      baseSaves: 21
    },
    {
      id: "atlas_temple_courtyard_bells",
      topicId: "temple-visit",
      filter: "Courtyard",
      creatorId: "user_mai",
      fallbackName: "Mai Putri",
      fallbackAvatar: fallbackFaces.user_mai,
      cover: still("atlas-stone-courtyard.jpg"),
      title: "Quiet pause by the temple gate",
      subtitle: "A small courtyard moment before the evening glow",
      body: "The courtyard stayed soft while the day slowed down. A few visitors paused near the gate, leaving the place with a peaceful rhythm.",
      details: [
        [kit("temple-pavilion.svg"), "Scene", "Stone gate"],
        [kit("mindful-leaf.png"), "Mood", "Peaceful pause"],
        [symbol("still-collection.svg"), "Memory", "Courtyard hour"]
      ],
      tags: ["Courtyard", "Festival Lights", "Temple Visit"],
      baseLikes: 24,
      baseSaves: 6
    },
    {
      id: "atlas_night_food_lane",
      topicId: "night-market",
      filter: "Food Lane",
      creatorId: "user_miso",
      fallbackName: "Niran Chai",
      fallbackAvatar: fallbackFaces.user_miso,
      cover: still("atlas-evening-stall.jpg"),
      title: "Dinner lane under amber lamps",
      subtitle: "Warm bowls, close tables, market light",
      body: "A short lane filled with bowls, steam, and careful hands. The best part was how ordinary it felt, as if the city saved this corner for slow evenings.",
      details: [
        [kit("street-bowl.png"), "Scene", "Food lane"],
        [kit("lantern-lane.svg"), "Mood", "Amber glow"],
        [symbol("note-bubble.svg"), "Memory", "Late dinner stop"]
      ],
      tags: ["Night Market", "Food Lane", "Evening Walk"],
      baseLikes: 37,
      baseSaves: 11
    }
  ];

  function currentUser(state) {
    var user = state && state.current_user;
    if (user && user.user_id) return user;
    return { user_id: "user_amy", display_name: "Havra", avatar_url: fallbackFaces.user_amy };
  }

  function findStoreUser(state, userId) {
    var source = state && Array.isArray(state.user_list) ? state.user_list : [];
    for (var index = 0; index < source.length; index += 1) {
      if (source[index] && source[index].user_id === userId) return source[index];
    }
    return null;
  }

  function findStorePost(state, postId) {
    var source = state && Array.isArray(state.pet_post_list) ? state.pet_post_list : [];
    for (var index = 0; index < source.length; index += 1) {
      if (source[index] && source[index].post_id === postId) return source[index];
    }
    return null;
  }

  function findTopic(topicId) {
    return atlasTopics.filter(function (topic) { return topic.id === topicId; })[0] || atlasTopics[0];
  }

  function findMoment(momentId) {
    return atlasMoments.filter(function (moment) { return moment.id === momentId; })[0] || null;
  }

  function isBlockedUser(userId) {
    var state = readAppState();
    var rows = Array.isArray(state.block_list) ? state.block_list : [];
    var person = currentUser(state);
    return rows.some(function (row) {
      return row && row.user_id === person.user_id && row.blocked_user_id === userId;
    });
  }

  function enrichedMoment(moment) {
    var state = readAppState();
    var user = findStoreUser(state, moment.creatorId) || {};
    var post = findStorePost(state, moment.id) || {};
    return Object.assign({}, moment, {
      creatorName: user.display_name || moment.fallbackName || post.creator_name || "Havra",
      creatorAvatar: user.avatar_url || moment.fallbackAvatar || post.creator_avatar_url || fallbackFaces.user_amy,
      creatorId: post.creator_id || moment.creatorId,
      title: moment.title,
      body: moment.body || post.post_text || "A small everyday memory from Southeast Asia.",
      cover: moment.cover || post.cover_image_url,
      baseLikes: typeof post.like_count === "number" ? post.like_count : moment.baseLikes,
      baseSaves: typeof post.save_count === "number" ? post.save_count : moment.baseSaves
    });
  }

  function topicMoments(topicId) {
    return atlasMoments.filter(function (moment) {
      return moment.topicId === topicId && !isBlockedUser(moment.creatorId) && (activeFilter === "All" || moment.filter === activeFilter);
    }).map(enrichedMoment);
  }

  function userHasReacted(listName, momentId) {
    var state = readAppState();
    var person = currentUser(state);
    var rows = Array.isArray(state[listName]) ? state[listName] : [];
    return rows.some(function (row) {
      return row && row.user_id === person.user_id && row.post_id === momentId;
    });
  }

  function toggleStoredReaction(listName, momentId, countField) {
    var state = readAppState();
    var person = currentUser(state);
    state[listName] = Array.isArray(state[listName]) ? state[listName] : [];
    var index = state[listName].findIndex(function (row) {
      return row && row.user_id === person.user_id && row.post_id === momentId;
    });
    var added = index < 0;
    if (added) {
      state[listName].push({ user_id: person.user_id, post_id: momentId, created_at: Date.now() });
    } else {
      state[listName].splice(index, 1);
    }
    if (Array.isArray(state.pet_post_list)) {
      var post = state.pet_post_list.filter(function (item) { return item && item.post_id === momentId; })[0];
      if (post && typeof post[countField] === "number") {
        post[countField] = Math.max(0, post[countField] + (added ? 1 : -1));
      }
    }
    writeAppState(state);
    var atlasReactions = readJson(reactionChannel, {});
    atlasReactions[momentId] = atlasReactions[momentId] || {};
    atlasReactions[momentId][listName] = added;
    writeJson(reactionChannel, atlasReactions);
    return added;
  }

  function readComments(momentId) {
    var allComments = readJson(commentChannel, {});
    var stored = Array.isArray(allComments[momentId]) ? allComments[momentId] : [];
    var moment = findMoment(momentId);
    var defaults = [
      { name: "Mai Putri", avatar: fallbackFaces.user_mai, text: "Love the early colors here." },
      { name: "Suri Lim", avatar: fallbackFaces.user_suri, text: "This feels like home." }
    ];
    if (moment && moment.topicId === "ferry-ride") {
      defaults = [
        { name: "Lina Santos", avatar: fallbackFaces.user_lina, text: "The morning route looks so calm." }
      ];
    }
    if (moment && moment.topicId === "night-market") {
      defaults = [
        { name: "Daniel Tran", avatar: fallbackFaces.user_daniel, text: "Warm lights make this lane beautiful." }
      ];
    }
    return defaults.concat(stored);
  }

  function addComment(momentId, text) {
    var trimmed = String(text || "").trim();
    if (!trimmed) {
      toast("Please enter a comment");
      return false;
    }
    var state = readAppState();
    var person = currentUser(state);
    var allComments = readJson(commentChannel, {});
    allComments[momentId] = Array.isArray(allComments[momentId]) ? allComments[momentId] : [];
    allComments[momentId].push({
      id: makeId("note"),
      name: person.display_name || "Havra",
      avatar: person.avatar_url || fallbackFaces.user_amy,
      text: trimmed,
      createdAt: Date.now()
    });
    writeJson(commentChannel, allComments);
    return true;
  }

  function toast(title) {
    if (window.uni && typeof window.uni.showToast === "function") {
      window.uni.showToast({ title: title, icon: "none" });
      return;
    }
    var oldToast = first(".havra-local-toast");
    if (oldToast) oldToast.remove();
    var node = document.createElement("div");
    node.className = "havra-local-toast";
    node.textContent = title;
    document.body.appendChild(node);
    setTimeout(function () { if (node.parentNode) node.parentNode.removeChild(node); }, 1800);
  }

  function activeHomeContainer() {
    return first('uni-page[data-page="pages/home/index"] .home-content') || first(".home-page .home-content");
  }

  function installHomeAtlas() {
    var homeContent = activeHomeContainer();
    if (!homeContent) return;
    byClass(".home-feed-section .home-section-title", homeContent).forEach(function (titleNode) {
      if (titleNode.textContent.trim() === "Local Guides") titleNode.textContent = "Local Stories";
    });
    if (first(".havra-life-atlas-section", homeContent)) return;
    var guideSection = first(".home-guide-section", homeContent);
    var greeting = first(".home-greeting", homeContent);
    if (!guideSection || !greeting) return;
    var section = document.createElement("div");
    section.className = "havra-life-atlas-section";
    var cards = atlasTopics.map(function (topic, index) {
      return '<div class="havra-life-card' + (index === 0 ? ' is-selected' : '') + '" data-havra-topic="' + topic.id + '">' +
        '<div class="havra-life-card__image" style="background-image:url(&quot;' + escapeText(topic.cover) + '&quot;)"></div>' +
        '<div class="havra-life-card__label">' +
          '<img class="havra-life-card__icon" src="' + escapeText(topic.cardIcon) + '" alt="">' +
          '<div class="havra-life-card__name">' + escapeText(topic.shortTitle).replace(/\n/g, "<br>") + '</div>' +
        '</div>' +
      '</div>';
    }).join("");
    section.innerHTML = '<div class="havra-life-atlas-title">Life Atlas</div><div class="havra-life-atlas-rail">' + cards + '</div>';
    homeContent.insertBefore(section, guideSection);
  }

  function bootHomeWatcher() {
    if (homeWatchArmed) return;
    homeWatchArmed = true;
    var pending = false;
    var run = function () {
      if (pending) return;
      pending = true;
      requestAnimationFrame(function () {
        pending = false;
        installHomeAtlas();
      });
    };
    if (document.readyState === "loading") {
      document.addEventListener("DOMContentLoaded", run);
    } else {
      run();
    }
    var target = document.getElementById("app") || document.body;
    new MutationObserver(run).observe(target, { childList: true, subtree: true });
    var retries = 0;
    var timer = setInterval(function () {
      retries += 1;
      installHomeAtlas();
      if (retries > 16) clearInterval(timer);
    }, 450);
  }

  function ensureOverlay() {
    if (overlayNode) return overlayNode;
    overlayNode = document.createElement("div");
    overlayNode.className = "havra-atlas-overlay";
    document.body.appendChild(overlayNode);
    document.documentElement.classList.add("havra-atlas-open");
    return overlayNode;
  }

  function closeOverlay(fromHistory) {
    closeCareSheet();
    if (overlayNode) {
      overlayNode.remove();
      overlayNode = null;
    }
    activeTopicId = "";
    activeMomentId = "";
    activeFilter = "All";
    document.documentElement.classList.remove("havra-atlas-open");
    if (fromHistory && installedHistoryDepth > 0) {
      installedHistoryDepth -= 1;
      history.back();
    }
  }

  function openTopic(topicId, useHistory) {
    var topic = findTopic(topicId);
    activeTopicId = topic.id;
    activeMomentId = "";
    activeFilter = "All";
    if (useHistory !== false) {
      try {
        history.pushState({ havraAtlasLayer: "topic", topicId: topic.id }, "", location.href);
        installedHistoryDepth += 1;
      } catch (error) {}
    }
    renderTopic();
  }

  function openMoment(momentId, useHistory) {
    var moment = findMoment(momentId);
    if (!moment) return;
    activeMomentId = moment.id;
    if (useHistory !== false) {
      try {
        history.pushState({ havraAtlasLayer: "moment", topicId: activeTopicId, momentId: moment.id }, "", location.href);
        installedHistoryDepth += 1;
      } catch (error) {}
    }
    renderMoment();
  }

  function goBackLayer() {
    if (installedHistoryDepth > 0) {
      installedHistoryDepth -= 1;
      history.back();
      return;
    }
    if (activeMomentId) {
      activeMomentId = "";
      renderTopic();
    } else {
      closeOverlay(false);
    }
  }

  window.addEventListener("popstate", function () {
    if (!overlayNode) return;
    if (activeMomentId) {
      activeMomentId = "";
      renderTopic();
      return;
    }
    closeOverlay(false);
  });

  function keepActiveFilterVisible(rail) {
    if (!rail) return;
    rail.scrollLeft = topicChipOffset;
    var selected = rail.querySelector(".havra-topic-chip.is-active");
    if (!selected) return;
    var railBounds = rail.getBoundingClientRect();
    var selectedBounds = selected.getBoundingClientRect();
    var breathingRoom = 10;
    if (selectedBounds.left < railBounds.left + breathingRoom) {
      rail.scrollLeft += selectedBounds.left - railBounds.left - breathingRoom;
    } else if (selectedBounds.right > railBounds.right - breathingRoom) {
      rail.scrollLeft += selectedBounds.right - railBounds.right + breathingRoom;
    }
    topicChipOffset = rail.scrollLeft;
  }

  function renderTopic() {
    var topic = findTopic(activeTopicId);
    var moments = topicMoments(topic.id);
    var node = ensureOverlay();
    var momentHtml = moments.map(function (moment) {
      var liked = userHasReacted("pet_post_like_list", moment.id);
      return '<div class="havra-topic-moment-card" data-havra-moment="' + escapeText(moment.id) + '">' +
        '<div class="havra-topic-moment-card__image" style="background-image:url(&quot;' + escapeText(moment.cover) + '&quot;)"></div>' +
        '<div class="havra-topic-moment-card__body">' +
          '<div class="havra-topic-moment-card__author"><img class="havra-topic-moment-card__avatar" src="' + escapeText(moment.creatorAvatar) + '" alt=""><div class="havra-topic-moment-card__name">' + escapeText(moment.creatorName) + '</div></div>' +
          '<div class="havra-topic-moment-card__title">' + escapeText(moment.title) + '</div>' +
          '<div class="havra-topic-moment-card__sub">' + escapeText(moment.subtitle) + '</div>' +
          '<div class="havra-topic-moment-card__filter">' + escapeText(moment.filter) + '</div>' +
        '</div>' +
        '<div class="havra-topic-moment-card__like" data-havra-like="' + escapeText(moment.id) + '"><img src="' + escapeText(symbol(liked ? "warm-heart-fill.svg" : "warm-heart.svg")) + '" alt=""></div>' +
        '<div class="havra-topic-moment-card__more" data-havra-care="' + escapeText(moment.id) + '"><img src="' + escapeText(symbol("more-column.svg")) + '" alt=""></div>' +
      '</div>';
    }).join("");
    var emptyHtml = '<div class="havra-atlas-empty"><div class="havra-atlas-empty__icon"><img src="' + escapeText(topic.cardIcon) + '" alt=""></div><h3>' + escapeText(topic.emptyTitle) + '</h3><p>' + escapeText(topic.emptyText) + '</p><button type="button" data-havra-create>Share Moment</button></div>';
    var previousRail = node.querySelector(".havra-topic-chips");
    if (previousRail) topicChipOffset = previousRail.scrollLeft;
    node.innerHTML = '<div class="havra-atlas-scroll">' +
      '<section class="havra-topic-hero" style="background-image:url(&quot;' + escapeText(topic.cover) + '&quot;)">' +
        '<div class="havra-round-action havra-topic-back" data-havra-back><img src="' + escapeText(symbol("back-chevron.svg")) + '" alt=""></div>' +
        '<div class="havra-topic-copy"><h1>' + escapeText(topic.title) + '</h1><p>' + escapeText(topic.subtitle) + '</p></div>' +
      '</section>' +
      '<div class="havra-topic-chips">' + topic.filters.map(function (filter) {
        return '<div class="havra-topic-chip' + (filter === activeFilter ? ' is-active' : '') + '" data-havra-filter="' + escapeText(filter) + '">' + escapeText(filter) + '</div>';
      }).join("") + '</div>' +
      '<h2 class="havra-topic-heading">Featured Moments</h2>' +
      '<div class="havra-moment-list">' + (moments.length ? momentHtml : emptyHtml) + '</div>' +
    '</div>';
    keepActiveFilterVisible(node.querySelector(".havra-topic-chips"));
  }

  function renderMoment() {
    var moment = enrichedMoment(findMoment(activeMomentId));
    if (!moment) return;
    var node = ensureOverlay();
    var liked = userHasReacted("pet_post_like_list", moment.id);
    var comments = readComments(moment.id);
    node.innerHTML = '<div class="havra-atlas-scroll">' +
      '<section class="havra-moment-hero" style="background-image:url(&quot;' + escapeText(moment.cover) + '&quot;)">' +
        '<div class="havra-round-action havra-moment-back" data-havra-back><img src="' + escapeText(symbol("back-chevron.svg")) + '" alt=""></div>' +
        '<div class="havra-round-action havra-moment-more" data-havra-care="' + escapeText(moment.id) + '"><img src="' + escapeText(symbol("more-column.svg")) + '" alt=""></div>' +
      '</section>' +
      '<main class="havra-moment-main">' +
        '<div class="havra-moment-author-row">' +
          '<img class="havra-moment-author-avatar" src="' + escapeText(moment.creatorAvatar) + '" alt="">' +
          '<div class="havra-moment-author-copy"><strong>' + escapeText(moment.creatorName) + '</strong><span>' + escapeText(findTopic(moment.topicId).title + ' · ' + moment.filter) + '</span></div>' +
          '<div class="havra-moment-reaction" data-havra-like="' + escapeText(moment.id) + '"><img src="' + escapeText(symbol(liked ? "warm-heart-fill.svg" : "warm-heart.svg")) + '" alt=""></div>' +
        '</div>' +
        '<h1 class="havra-moment-title">' + escapeText(moment.title) + '</h1>' +
        '<p class="havra-moment-text">' + escapeText(moment.body) + '</p>' +
        '<h2 class="havra-moment-section-title">Moment  Brief</h2>' +
        '<div class="havra-moment-detail-box">' + moment.details.map(function (detail) {
          return '<div class="havra-moment-detail-row"><img src="' + escapeText(detail[0]) + '" alt=""><span><strong>' + escapeText(detail[1]) + ':</strong> ' + escapeText(detail[2]) + '</span></div>';
        }).join("") + '</div>' +
        '<div class="havra-moment-tag-row">' + moment.tags.map(function (tag) { return '<span class="havra-moment-tag">' + escapeText(tag) + '</span>'; }).join("") + '</div>' +
        '<h2 class="havra-moment-section-title">Thoughtful Comments</h2>' +
        '<div class="havra-comment-list">' + comments.map(function (comment) {
          return '<div class="havra-comment-card"><img class="havra-comment-avatar" src="' + escapeText(comment.avatar) + '" alt=""><div class="havra-comment-copy"><strong>' + escapeText(comment.name) + '</strong><span>' + escapeText(comment.text) + '</span></div><img class="havra-comment-mini-heart" src="' + escapeText(symbol("warm-heart.svg")) + '" alt=""></div>';
        }).join("") + '</div>' +
        '<div class="havra-comment-compose"><input data-havra-comment-input type="text" placeholder="Add a thoughtful note"><button class="havra-comment-send" type="button" data-havra-comment-send><img src="' + escapeText(symbol("dispatch-arrow.svg")) + '" alt=""></button></div>' +
      '</main>' +
    '</div>';
  }

  function reportReasons() {
    var state = readAppState();
    var rows = Array.isArray(state.report_reason_list) ? state.report_reason_list : [];
    if (rows.length) {
      return rows.map(function (row) {
        return { id: row.reason_id || row.id || row.title, title: row.title || row.reason || "Inappropriate content" };
      });
    }
    return [
      { id: "care_spam", title: "Unwanted or repetitive content" },
      { id: "care_harm", title: "Harmful or disrespectful content" },
      { id: "care_other", title: "Other concern" }
    ];
  }

  function closeCareSheet() {
    if (careNode) {
      careNode.remove();
      careNode = null;
    }
  }

  function openCareSheet(momentId) {
    var moment = enrichedMoment(findMoment(momentId));
    if (!moment) return;
    var state = readAppState();
    var person = currentUser(state);
    if (moment.creatorId === person.user_id) {
      toast("You cannot report yourself");
      return;
    }
    closeCareSheet();
    var reasons = reportReasons();
    var selectedId = reasons[0] ? reasons[0].id : "care_other";
    careNode = document.createElement("div");
    careNode.className = "havra-care-layer";
    careNode.innerHTML = '<div class="havra-care-dim" data-havra-care-close></div>' +
      '<div class="havra-care-sheet">' +
        '<div class="havra-care-handle"></div>' +
        '<h3>Report Moment</h3>' +
        '<p>Select a reason or block this profile from your Havra experience.</p>' +
        '<div class="havra-care-reasons">' + reasons.map(function (reason, index) {
          return '<div class="havra-care-reason' + (index === 0 ? ' is-active' : '') + '" data-havra-reason="' + escapeText(reason.id) + '"><span>' + escapeText(reason.title) + '</span><span>' + (index === 0 ? '✓' : '') + '</span></div>';
        }).join("") + '</div>' +
        '<div class="havra-care-actions"><button class="havra-care-primary" type="button" data-havra-submit-care>Submit Report</button><button class="havra-care-soft" type="button" data-havra-block-person>Block Profile</button><button class="havra-care-soft" type="button" data-havra-care-close>Cancel</button></div>' +
      '</div>';
    careNode.dataset.momentId = moment.id;
    careNode.dataset.creatorId = moment.creatorId;
    careNode.dataset.reasonId = selectedId;
    document.body.appendChild(careNode);
  }

  function submitReport() {
    if (!careNode) return;
    var momentId = careNode.dataset.momentId;
    var creatorId = careNode.dataset.creatorId;
    var reasonId = careNode.dataset.reasonId || "care_other";
    var state = readAppState();
    var person = currentUser(state);
    state.report_list = Array.isArray(state.report_list) ? state.report_list : [];
    state.report_list.unshift({
      report_id: makeId("report"),
      user_id: person.user_id,
      reported_user_id: creatorId,
      post_id: momentId,
      reason_id: reasonId,
      report_context: "life_atlas_moment",
      created_at: Date.now()
    });
    writeAppState(state);
    closeCareSheet();
    toast("Report submitted");
  }

  function blockCreator() {
    if (!careNode) return;
    var creatorId = careNode.dataset.creatorId;
    var state = readAppState();
    var person = currentUser(state);
    if (creatorId === person.user_id) {
      closeCareSheet();
      toast("You cannot report yourself");
      return;
    }
    state.block_list = Array.isArray(state.block_list) ? state.block_list : [];
    var exists = state.block_list.some(function (row) {
      return row && row.user_id === person.user_id && row.blocked_user_id === creatorId;
    });
    if (!exists) {
      state.block_list.push({
        block_id: makeId("block"),
        user_id: person.user_id,
        blocked_user_id: creatorId,
        reason: "life_atlas_moment",
        created_at: Date.now()
      });
    }
    writeAppState(state);
    closeCareSheet();
    toast("Profile blocked");
    if (activeMomentId) {
      activeMomentId = "";
      renderTopic();
    } else if (activeTopicId) {
      renderTopic();
    }
  }

  function openCreateEntry() {
    closeOverlay(false);
    if (window.uni && typeof window.uni.switchTab === "function") {
      try { window.uni.switchTab({ url: "/pages/create/index" }); return; } catch (error) {}
    }
    if (window.uni && typeof window.uni.navigateTo === "function") {
      try { window.uni.navigateTo({ url: "/pages/create/index" }); return; } catch (error) {}
    }
    window.location.hash = "#/pages/create/index";
  }

  document.addEventListener("click", function (event) {
    var topicCard = event.target.closest("[data-havra-topic]");
    if (topicCard) {
      event.preventDefault();
      event.stopPropagation();
      openTopic(topicCard.dataset.havraTopic, true);
      return;
    }
    var backNode = event.target.closest("[data-havra-back]");
    if (backNode) {
      event.preventDefault();
      goBackLayer();
      return;
    }
    var filterNode = event.target.closest("[data-havra-filter]");
    if (filterNode) {
      var filterRail = filterNode.closest(".havra-topic-chips");
      if (filterRail) topicChipOffset = filterRail.scrollLeft;
      activeFilter = filterNode.dataset.havraFilter || "All";
      renderTopic();
      return;
    }
    var createNode = event.target.closest("[data-havra-create]");
    if (createNode) {
      openCreateEntry();
      return;
    }
    var likeNode = event.target.closest("[data-havra-like]");
    if (likeNode) {
      event.preventDefault();
      event.stopPropagation();
      toggleStoredReaction("pet_post_like_list", likeNode.dataset.havraLike, "like_count");
      if (activeMomentId) renderMoment(); else renderTopic();
      return;
    }
    var saveNode = event.target.closest("[data-havra-save], [data-havra-topic-save]");
    if (saveNode) {
      event.preventDefault();
      event.stopPropagation();
      if (activeMomentId) toggleStoredReaction("pet_post_save_list", activeMomentId, "save_count");
      toast("Saved to your atlas");
      if (activeMomentId) renderMoment();
      return;
    }
    var careTrigger = event.target.closest("[data-havra-care]");
    if (careTrigger) {
      event.preventDefault();
      event.stopPropagation();
      openCareSheet(careTrigger.dataset.havraCare);
      return;
    }
    var momentNode = event.target.closest("[data-havra-moment]");
    if (momentNode) {
      event.preventDefault();
      event.stopPropagation();
      openMoment(momentNode.dataset.havraMoment, true);
      return;
    }
    var reasonNode = event.target.closest("[data-havra-reason]");
    if (reasonNode && careNode) {
      byClass(".havra-care-reason", careNode).forEach(function (node) {
        node.classList.remove("is-active");
        var mark = node.querySelector("span:last-child");
        if (mark) mark.textContent = "";
      });
      reasonNode.classList.add("is-active");
      var activeMark = reasonNode.querySelector("span:last-child");
      if (activeMark) activeMark.textContent = "✓";
      careNode.dataset.reasonId = reasonNode.dataset.havraReason;
      return;
    }
    if (event.target.closest("[data-havra-submit-care]")) {
      submitReport();
      return;
    }
    if (event.target.closest("[data-havra-block-person]")) {
      blockCreator();
      return;
    }
    if (event.target.closest("[data-havra-care-close]")) {
      closeCareSheet();
      return;
    }
    if (event.target.closest("[data-havra-comment-send]")) {
      var input = first("[data-havra-comment-input]", overlayNode);
      if (input && addComment(activeMomentId, input.value)) {
        renderMoment();
        setTimeout(function () {
          var nextInput = first("[data-havra-comment-input]", overlayNode);
          if (nextInput) nextInput.focus();
        }, 80);
      }
    }
  }, true);

  document.addEventListener("keydown", function (event) {
    if (event.key !== "Enter") return;
    var input = event.target && event.target.closest ? event.target.closest("[data-havra-comment-input]") : null;
    if (!input) return;
    if (addComment(activeMomentId, input.value)) {
      renderMoment();
    }
  });

  bootHomeWatcher();
})();
