(function () {
  "use strict";

  var orchardKey = "pet_one_state";
  var localPulseKey = "havra_journey_pulse";
  var noteKey = "havra_journey_notes";
  var activeLane = "All";
  var careLayer = null;
  var detailLayer = null;
  var activeJourneyPostId = "";
  var guardStamp = "";
  var domStamp = "";
  var lastPageNode = null;
  var renderLock = false;
  var retiredRowsTrimmed = false;
  var lastDetailReturnAt = 0;
  var laneRailOffset = 0;

  function readJson(key, fallbackValue) {
    try {
      var raw = localStorage.getItem(key);
      return raw ? JSON.parse(raw) : fallbackValue;
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

  function readState() {
    return readJson(orchardKey, {});
  }

  function saveState(nextState) {
    writeJson(orchardKey, nextState || {});
  }

  function asset(path) {
    var cleaned = String(path || "").replace(/^\.\//, "").replace(/^\/+/, "");
    if (window.__havraAssetUrl) return window.__havraAssetUrl(cleaned);
    if (window.location.href.indexOf("havra-runtime://") === 0) return "havra-runtime://app/" + cleaned;
    return "./" + cleaned;
  }

  function still(name) {
    return asset("havra-atlas/visual-set/scene-stills/" + name);
  }

  function face(name) {
    return asset("havra-atlas/visual-set/profile-faces/" + name);
  }

  function symbol(name) {
    return asset("havra-atlas/visual-set/interface-symbols/" + name);
  }

  function kit(name) {
    return asset("havra-atlas/publish-kit/" + name);
  }

  function reel(name) {
    return asset("havra-atlas/visual-set/story-reels/" + name);
  }

  function escapeText(value) {
    return String(value == null ? "" : value).replace(/[&<>\"]/g, function (mark) {
      return { "&": "&amp;", "<": "&lt;", ">": "&gt;", "\"": "&quot;" }[mark];
    });
  }

  var faceBank = {
    user_amy: face("face-bangkok-guide.png"),
    user_mai: face("face-bali-morning.png"),
    user_daniel: face("face-hanoi-reader.png"),
    user_lina: face("face-manila-sunset.png"),
    user_miso: face("face-bangkok-lane.png"),
    user_suri: face("face-penang-craft.png")
  };

  var briefMap = {
    "All": {
      title: "Southeast Everyday Atlas",
      text: "Market mornings, ferry rails, temple courtyards, shaded tables, shorelines, and lantern streets.",
      mark: "Today in Havra",
      cover: still("atlas-everyday-mosaic.png"),
      icon: symbol("sun-medallion.svg"),
      empty: "Be the first to add a Southeast Asian everyday moment."
    },
    "Temple Visit": {
      title: "Temple Visit",
      text: "Sunlit stone gates, quiet offerings, and lantern shade",
      mark: "Today in Havra",
      cover: still("atlas-temple-courtyard-dawn.png"),
      icon: kit("temple-pavilion.svg"),
      empty: "Be the first to add a temple memory."
    },
    "Dining": {
      title: "Dining",
      text: "Shared dishes, shaded tables, and warm kitchen corners",
      mark: "Table Notes",
      cover: still("atlas-dining-table-shade.png"),
      icon: kit("street-bowl.png"),
      empty: "Be the first to add a dining note."
    },
    "Island Hop": {
      title: "Island Hop",
      text: "Small boats, turquoise coves, and soft crossings",
      mark: "Coastal Route",
      cover: still("atlas-island-lagoon-route.png"),
      icon: kit("island-palm.svg"),
      empty: "Be the first to add an island route."
    }
  };

  var laneOrder = ["All", "Temple Visit", "Dining", "Island Hop", "Photos", "Videos"];
  var originalLaneMap = { "All": true, "Photos": true, "Videos": true };

  function isOriginalLane(lane) {
    return originalLaneMap[lane] === true;
  }

  function originalLaneName() {
    return activeLane === "Photos" || activeLane === "Videos" ? activeLane : "All";
  }

  var sourceCards = [
    {
      postId: "journey_temple_offering",
      lane: "Temple Visit",
      title: "Morning offerings at the temple",
      kind: "photo",
      cover: still("journey-temple-offering.jpg"),
      creatorId: "user_suri",
      fallbackName: "Suri Lim",
      fallbackAvatar: faceBank.user_suri,
      likes: 328,
      short: false,
      sourceText: "Incense drifted through the courtyard as the morning offerings began.",
      statusTag: "culture",
      moodTag: "mindful",
      publishedAt: "July 12, 2026 07:35"
    },
    {
      postId: "journey_temple_lantern_path",
      lane: "Temple Visit",
      title: "Evening lantern walk in Ubud",
      kind: "photo",
      cover: still("journey-temple-lantern-path.jpg"),
      creatorId: "user_amy",
      fallbackName: "Havra",
      fallbackAvatar: faceBank.user_amy,
      likes: 176,
      short: false,
      sourceText: "Lanterns warmed the temple lane as visitors moved through the dusk.",
      statusTag: "culture",
      moodTag: "inspired",
      publishedAt: "July 11, 2026 18:40"
    },
    {
      postId: "journey_hanoi_lunch_stall",
      lane: "Dining",
      title: "Hanoi lunch stall after rain",
      kind: "photo",
      cover: still("journey-hanoi-lunch-stall.jpg"),
      creatorId: "user_daniel",
      fallbackName: "Daniel Tran",
      fallbackAvatar: faceBank.user_daniel,
      likes: 512,
      short: true,
      sourceText: "A simple Hanoi lunch with bright herbs and a tiny plastic stool.",
      statusTag: "food-finds",
      moodTag: "curious",
      publishedAt: "July 10, 2026 12:20"
    },
    {
      postId: "journey_bali_coffee_shade",
      lane: "Dining",
      title: "Coffee stop under cool shade",
      kind: "photo",
      cover: still("journey-bali-coffee-shade.jpg"),
      creatorId: "user_mai",
      fallbackName: "Mai Putri",
      fallbackAvatar: faceBank.user_mai,
      likes: 204,
      short: false,
      sourceText: "A peaceful Bali coffee stop with plenty of shade.",
      statusTag: "coffee-stop",
      moodTag: "easy-going",
      publishedAt: "July 9, 2026 08:35"
    },
    {
      postId: "journey_island_ferry_rails",
      lane: "Island Hop",
      title: "Ferry ride between bright shores",
      kind: "photo",
      cover: still("journey-island-ferry-rails.jpg"),
      creatorId: "user_amy",
      fallbackName: "Havra",
      fallbackAvatar: faceBank.user_amy,
      likes: 640,
      short: false,
      sourceText: "Salt wind and quiet rails on the way between bright shores.",
      statusTag: "weekend-trip",
      moodTag: "inspired",
      publishedAt: "July 5, 2026 15:30"
    },
    {
      postId: "journey_cebu_bright_shore",
      lane: "Island Hop",
      title: "Cebu bright shore afternoon",
      kind: "photo",
      cover: still("journey-cebu-bright-shore.jpg"),
      creatorId: "user_amy",
      fallbackName: "Havra",
      fallbackAvatar: faceBank.user_amy,
      likes: 204,
      short: true,
      sourceText: "Green cliffs and bright water on a slow island afternoon.",
      statusTag: "nature",
      moodTag: "joyful",
      publishedAt: "July 4, 2026 13:25"
    }
  ];

  var detailBank = {
    journey_temple_offering: {
      lead: "Morning offerings at the temple",
      body: "Suri paused at the edge of the courtyard as incense smoke folded into the morning light. The offering baskets, stone gates, and quiet footsteps made the whole lane feel gentle before the city became busy.",
      scene: "Temple courtyard",
      mood: "Mindful morning",
      memory: "First incense light",
      tags: ["Temple Visit", "Morning Offering", "Stone Gate"],
      notes: [
        { userId: "user_mai", text: "The morning light in this courtyard feels so peaceful." },
        { userId: "user_daniel", text: "I like how quiet this offering moment feels." }
      ]
    },
    journey_temple_lantern_path: {
      lead: "Evening lantern walk in Ubud",
      body: "Lanterns warmed the narrow path while temple silhouettes held the last color of the day. A slow walk became a small memory of dusk, stone, and soft gold.",
      scene: "Lantern path",
      mood: "Warm evening",
      memory: "Dusk beside carved gates",
      tags: ["Temple Visit", "Lantern Walk", "Ubud Evening"],
      notes: [
        { userId: "user_suri", text: "The lantern glow makes the path feel calm." }
      ]
    },
    journey_hanoi_lunch_stall: {
      lead: "Hanoi lunch stall after rain",
      body: "After a brief rain, the lunch stall filled with steam, herbs, and the sound of small bowls being set down. Daniel saved the moment because it felt simple, warm, and completely local.",
      scene: "Lunch stall",
      mood: "After-rain warmth",
      memory: "Herbs on a tiny table",
      tags: ["Dining", "Hanoi Lunch", "Street Table"],
      notes: [
        { userId: "user_lina", text: "This feels like the best kind of rainy-day lunch." },
        { userId: "user_suri", text: "The colors on the table are beautiful." }
      ]
    },
    journey_bali_coffee_shade: {
      lead: "Coffee stop under cool shade",
      body: "Mai found a quiet coffee corner where the afternoon stayed cool under woven shade. Cups, slow conversations, and passing scooters made the stop feel easy to remember.",
      scene: "Coffee corner",
      mood: "Easy-going shade",
      memory: "Slow cups after breakfast",
      tags: ["Dining", "Coffee Stop", "Bali Shade"],
      notes: [
        { userId: "user_daniel", text: "That shaded table looks perfect for a slow afternoon." }
      ]
    },
    journey_island_ferry_rails: {
      lead: "Ferry ride between bright shores",
      body: "The ferry moved through clear water with salt wind along the rails. The shore kept changing shape, turning the crossing into a quiet island route.",
      scene: "Ferry rails",
      mood: "Open water",
      memory: "Bright shore crossing",
      tags: ["Island Hop", "Ferry Ride", "Coastal Route"],
      notes: [
        { userId: "user_mai", text: "The water color makes this route feel so fresh." },
        { userId: "user_suri", text: "I can almost feel the wind from the deck." }
      ]
    },
    journey_cebu_bright_shore: {
      lead: "Cebu bright shore afternoon",
      body: "Green cliffs leaned toward a bright quiet beach while the afternoon moved slowly. This little island stop felt open, sunny, and far from the rush of the city.",
      scene: "Bright shore",
      mood: "Clear afternoon",
      memory: "Green cliffs over water",
      tags: ["Island Hop", "Beach Day", "Cebu Shore"],
      notes: [
        { userId: "user_lina", text: "The cliffs and water look like a perfect afternoon stop." }
      ]
    }
  };

  function currentUser(state) {
    var user = state && state.current_user;
    if (user && user.user_id) return user;
    return { user_id: "user_amy", display_name: "Havra", avatar_url: faceBank.user_amy };
  }

  function findUser(state, userId) {
    var users = Array.isArray(state.user_list) ? state.user_list : [];
    for (var index = 0; index < users.length; index += 1) {
      if (users[index] && users[index].user_id === userId) return users[index];
    }
    return null;
  }

  function findPost(state, postId) {
    var posts = Array.isArray(state.pet_post_list) ? state.pet_post_list : [];
    for (var index = 0; index < posts.length; index += 1) {
      if (posts[index] && posts[index].post_id === postId) return posts[index];
    }
    return null;
  }

  function findJourneyCard(postId) {
    for (var index = 0; index < sourceCards.length; index += 1) {
      if (sourceCards[index] && sourceCards[index].postId === postId) return sourceCards[index];
    }
    return null;
  }

  function detailInfo(postId) {
    return detailBank[postId] || {};
  }

  function journeyNoteCount(postId) {
    var info = detailInfo(postId);
    var seeded = Array.isArray(info.notes) ? info.notes.length : 0;
    var saved = readJson(noteKey, {});
    var rows = Array.isArray(saved[postId]) ? saved[postId].length : 0;
    return seeded + rows;
  }

  function pruneRetiredJourneyRows() {
    var keepers = {};
    sourceCards.forEach(function (row) {
      keepers[row.postId] = true;
    });
    var state = readState();
    var rows = Array.isArray(state.pet_post_list) ? state.pet_post_list : [];
    var nextRows = rows.filter(function (row) {
      var postId = row && row.post_id;
      return !(typeof postId === "string" && postId.indexOf("journey_") === 0 && !keepers[postId]);
    });
    if (nextRows.length !== rows.length) {
      state.pet_post_list = nextRows;
      saveState(state);
    }
  }

  function creatorPetId(state, creatorId) {
    var rows = Array.isArray(state.pet_list) ? state.pet_list : [];
    for (var index = 0; index < rows.length; index += 1) {
      var pet = rows[index] || {};
      if (pet.owner_user_id === creatorId || pet.user_id === creatorId || pet.creator_id === creatorId) return pet.pet_id || pet.id || "";
    }
    return "atlas_" + String(creatorId || "guide").replace(/^user_/, "");
  }

  function journeyPostText(item) {
    var title = String(item && item.title || "").trim();
    var body = String(item && item.sourceText || "").trim();
    if (!title) return body;
    if (!body) return title;
    return title + ". " + body;
  }

  function journeyPostShape(item, currentPost, state) {
    var current = currentPost || {};
    var user = findUser(state, item.creatorId) || {};
    var likeCount = typeof current.like_count === "number" ? current.like_count : item.likes;
    var saveCount = typeof current.save_count === "number" ? current.save_count : Math.max(1, Math.round((item.likes || 0) / 3));
    var noteCount = Math.max(typeof current.comment_count === "number" ? current.comment_count : 0, journeyNoteCount(item.postId));
    return {
      post_id: item.postId,
      creator_id: item.creatorId,
      creator_name: user.display_name || item.fallbackName || "Havra",
      creator_avatar_url: user.avatar_url || item.fallbackAvatar || faceBank.user_amy,
      pet_id: creatorPetId(state, item.creatorId),
      pet_name: user.display_name || item.fallbackName || "Havra",
      content_type: item.kind || "photo",
      cover_image_url: item.cover,
      media_url: item.kind === "video" ? item.media || item.cover : item.cover,
      post_text: journeyPostText(item),
      pet_status_tag: item.statusTag || "culture",
      mood_tag: item.moodTag || "curious",
      coin_cost: item.kind === "video" ? 20 : 0,
      like_count: likeCount,
      save_count: saveCount,
      comment_count: noteCount,
      square_card_height: item.short ? 185 : 220,
      is_featured: false,
      is_public: true,
      published_at: item.publishedAt || "June 30, 2026 08:00"
    };
  }

  function ensureJourneyPost(postId) {
    var item = findJourneyCard(postId);
    if (!item) return null;
    var state = readState();
    state.pet_post_list = Array.isArray(state.pet_post_list) ? state.pet_post_list : [];
    var rows = state.pet_post_list;
    var foundIndex = -1;
    for (var index = 0; index < rows.length; index += 1) {
      if (rows[index] && rows[index].post_id === postId) {
        foundIndex = index;
        break;
      }
    }
    var oldPost = foundIndex >= 0 ? rows[foundIndex] : null;
    var nextPost = journeyPostShape(item, oldPost, state);
    var changed = foundIndex < 0;
    if (oldPost) {
      var fieldNames = Object.keys(nextPost);
      for (var fieldIndex = 0; fieldIndex < fieldNames.length; fieldIndex += 1) {
        var fieldName = fieldNames[fieldIndex];
        if (oldPost[fieldName] !== nextPost[fieldName]) {
          changed = true;
          break;
        }
      }
    }
    if (foundIndex >= 0) {
      rows[foundIndex] = nextPost;
    } else {
      rows.push(nextPost);
    }
    if (changed) saveState(state);
    return nextPost;
  }

  function isBlocked(creatorId) {
    var state = readState();
    var person = currentUser(state);
    var rows = Array.isArray(state.block_list) ? state.block_list : [];
    return rows.some(function (row) {
      if (!row) return false;
      return row.blocked_user_id === creatorId || row.user_id === creatorId || row.owner_user_id === creatorId && row.viewer_user_id === person.user_id;
    });
  }

  function liked(postId) {
    var state = readState();
    var person = currentUser(state);
    var rows = Array.isArray(state.pet_post_like_list) ? state.pet_post_like_list : [];
    return rows.some(function (row) { return row && row.user_id === person.user_id && row.post_id === postId; });
  }

  function toggleLike(postId) {
    var state = readState();
    var person = currentUser(state);
    state.pet_post_like_list = Array.isArray(state.pet_post_like_list) ? state.pet_post_like_list : [];
    var index = state.pet_post_like_list.findIndex(function (row) {
      return row && row.user_id === person.user_id && row.post_id === postId;
    });
    var nextLiked = index < 0;
    if (nextLiked) {
      state.pet_post_like_list.push({ user_id: person.user_id, post_id: postId, created_at: Date.now() });
    } else {
      state.pet_post_like_list.splice(index, 1);
    }
    var post = findPost(state, postId);
    if (post && typeof post.like_count === "number") post.like_count = Math.max(0, post.like_count + (nextLiked ? 1 : -1));
    saveState(state);
    var pulse = readJson(localPulseKey, {});
    pulse[postId] = nextLiked;
    writeJson(localPulseKey, pulse);
    return nextLiked;
  }

  function enriched(item) {
    var state = readState();
    var post = findPost(state, item.postId) || {};
    var creatorId = item.creatorId || post.creator_id;
    var user = findUser(state, creatorId) || {};
    return Object.assign({}, item, {
      creatorId: creatorId,
      creatorName: user.display_name || item.fallbackName || post.creator_name || "Havra",
      creatorAvatar: user.avatar_url || item.fallbackAvatar || post.creator_avatar_url || faceBank.user_amy,
      kind: item.kind || post.content_type || "photo",
      likeCount: typeof post.like_count === "number" ? post.like_count : item.likes,
      sourceText: item.sourceText || post.post_text || item.title
    });
  }

  function noteProfile(state, row) {
    var userId = row.userId || row.user_id || "";
    var user = findUser(state, userId) || {};
    return {
      name: user.display_name || row.userName || row.user_name || row.fallbackName || "Havra",
      avatar: user.avatar_url || row.avatarUrl || row.avatar_url || faceBank[userId] || faceBank.user_amy,
      text: row.text || row.note_text || ""
    };
  }

  function seededNotes(item) {
    var info = detailInfo(item.postId);
    var rows = Array.isArray(info.notes) ? info.notes : [];
    return rows.map(function (row, index) {
      return {
        note_id: item.postId + "_seed_" + index,
        post_id: item.postId,
        userId: row.userId,
        text: row.text
      };
    });
  }

  function savedNotes(postId) {
    var bag = readJson(noteKey, {});
    return Array.isArray(bag[postId]) ? bag[postId] : [];
  }

  function detailNotes(item) {
    var state = readState();
    return seededNotes(item).concat(savedNotes(item.postId)).map(function (row) {
      return noteProfile(state, row);
    }).filter(function (row) {
      return row && row.text;
    });
  }

  function appendJourneyNote(postId, value) {
    var item = findJourneyCard(postId);
    var text = String(value || "").trim();
    if (!item) return false;
    if (!text) {
      toast("Please add a thoughtful note");
      return false;
    }
    var state = readState();
    var person = currentUser(state);
    var bag = readJson(noteKey, {});
    bag[postId] = Array.isArray(bag[postId]) ? bag[postId] : [];
    bag[postId].push({
      note_id: "journey_note_" + Date.now().toString(36),
      post_id: postId,
      userId: person.user_id,
      userName: person.display_name || person.nickname || "Havra",
      avatarUrl: person.avatar_url || faceBank.user_amy,
      text: text,
      createdAt: Date.now()
    });
    writeJson(noteKey, bag);
    ensureJourneyPost(postId);
    state = readState();
    var post = findPost(state, postId);
    if (post) {
      post.comment_count = journeyNoteCount(postId);
      saveState(state);
    }
    return true;
  }

  function detailLine(iconUrl, label, text) {
    return '<div class="havra-journey-detail__line"><img src="' + escapeText(iconUrl) + '" alt=""><span>' + escapeText(label) + ':</span><strong>' + escapeText(text) + '</strong></div>';
  }

  function detailLines(item) {
    var info = detailInfo(item.postId);
    return [
      detailLine(kit(item.kind === "video" ? "atlas-reel-ready.png" : "atlas-still-ready.png"), "Format", item.kind === "video" ? "Travel Vlog" : "Photo Story"),
      detailLine(kit("curiosity-compass.png"), "Scene", info.scene || item.lane),
      detailLine(kit("mindful-leaf.png"), "Mood", info.mood || item.moodTag || "Curious")
    ].join("");
  }

  function detailTags(item) {
    var info = detailInfo(item.postId);
    var rows = Array.isArray(info.tags) && info.tags.length ? info.tags : [item.lane, item.statusTag, item.moodTag];
    return rows.filter(Boolean).map(function (tag) {
      return '<span class="havra-journey-detail__tag">' + escapeText(tag) + '</span>';
    }).join("");
  }

  function detailNoteMarkup(item) {
    var rows = detailNotes(item);
    if (!rows.length) {
      return '<div class="havra-journey-detail__note-empty">No thoughtful comments yet</div>';
    }
    return rows.map(function (row) {
      return '<div class="havra-journey-detail__note"><img src="' + escapeText(row.avatar) + '" alt=""><div><strong>' + escapeText(row.name) + '</strong><p>' + escapeText(row.text) + '</p></div></div>';
    }).join("");
  }

  function closeJourneyDetail() {
    if (detailLayer) {
      detailLayer.remove();
      detailLayer = null;
    }
    activeJourneyPostId = "";
    document.documentElement.classList.remove("havra-journey-detail-open");
  }

  function renderJourneyDetail(postId) {
    var item = findJourneyCard(postId);
    if (!item) return;
    ensureJourneyPost(postId);
    item = enriched(item);
    activeJourneyPostId = postId;
    var info = detailInfo(postId);
    var isVlog = item.kind === "video";
    var isLiked = liked(postId);
    if (!detailLayer) {
      detailLayer = document.createElement("div");
      document.body.appendChild(detailLayer);
    }
    detailLayer.className = "havra-journey-detail-layer";
    detailLayer.dataset.postId = postId;
    detailLayer.innerHTML = '<section class="havra-journey-detail" data-havra-journey-detail="' + escapeText(postId) + '">' +
      '<div class="havra-journey-detail__hero" style="background-image:url(&quot;' + escapeText(item.cover) + '&quot;)">' +
        '<button class="havra-journey-detail__back" type="button" data-havra-journey-detail-close><img src="' + escapeText(symbol("back-chevron.svg")) + '" alt=""></button>' +
        '<button class="havra-journey-detail__more" type="button" data-havra-detail-care="' + escapeText(postId) + '"><img src="' + escapeText(symbol("more-column.svg")) + '" alt=""></button>' +
        (isVlog ? '<div class="havra-journey-detail__play"></div>' : '') +
      '</div>' +
      '<div class="havra-journey-detail__body">' +
        '<div class="havra-journey-detail__author">' +
          '<img class="havra-journey-detail__avatar" src="' + escapeText(item.creatorAvatar) + '" alt="">' +
          '<div class="havra-journey-detail__who"><strong>' + escapeText(item.creatorName) + '</strong><span>' + escapeText(item.lane) + ' · ' + escapeText(item.statusTag || "Today in Havra") + '</span></div>' +
          '<button class="havra-journey-detail__round' + (isLiked ? ' is-active' : '') + '" type="button" data-havra-detail-like="' + escapeText(postId) + '"><img src="' + escapeText(symbol(isLiked ? "warm-heart-fill.svg" : "warm-heart.svg")) + '" alt=""></button>' +
        '</div>' +
        '<h1>' + escapeText(info.lead || item.title) + '</h1>' +
        '<p class="havra-journey-detail__copy">' + escapeText(info.body || item.sourceText) + '</p>' +
        '<h2>Moment Brief:</h2>' +
        '<div class="havra-journey-detail__lines">' + detailLines(item) + '</div>' +
        '<div class="havra-journey-detail__tags">' + detailTags(item) + '</div>' +
        '<h2>Thoughtful Comments</h2>' +
        '<div class="havra-journey-detail__notes">' + detailNoteMarkup(item) + '</div>' +
        '<div class="havra-journey-detail__composer"><input type="text" data-havra-detail-note-input placeholder="Add a thoughtful note"><button type="button" data-havra-detail-note-send="' + escapeText(postId) + '"><img src="' + escapeText(symbol("dispatch-arrow.svg")) + '" alt=""></button></div>' +
      '</div>' +
    '</section>';
    document.documentElement.classList.add("havra-journey-detail-open");
  }

  function wallPage() {
    return document.querySelector('uni-page[data-page="pages/wall/index"] .square-page') || document.querySelector(".square-page");
  }

  function ensureOriginalLane(page) {
    var header = page && page.querySelector(".square-fixed-header");
    if (!header) return;
    var chips = Array.prototype.slice.call(header.querySelectorAll(".category-chip"));
    var targetName = originalLaneName();
    var targetChip = chips.filter(function (chip) { return chip.textContent.trim() === targetName; })[0];
    if (targetChip && !targetChip.className.match(/category-chip--active/)) {
      setTimeout(function () { try { targetChip.click(); } catch (error) {} }, 0);
    }
  }

  function keepActiveLaneVisible(rail) {
    if (!rail) return;
    rail.scrollLeft = laneRailOffset;
    var selected = rail.querySelector(".havra-journey-chip.is-active");
    if (!selected) return;
    var railBounds = rail.getBoundingClientRect();
    var selectedBounds = selected.getBoundingClientRect();
    var breathingRoom = 10;
    if (selectedBounds.left < railBounds.left + breathingRoom) {
      rail.scrollLeft += selectedBounds.left - railBounds.left - breathingRoom;
    } else if (selectedBounds.right > railBounds.right - breathingRoom) {
      rail.scrollLeft += selectedBounds.right - railBounds.right + breathingRoom;
    }
    laneRailOffset = rail.scrollLeft;
  }

  function installHeader(page) {
    var header = page && page.querySelector(".square-fixed-header");
    if (!header) return false;
    var oldPanel = header.querySelector(".havra-journey-panel");
    var oldRail = oldPanel && oldPanel.querySelector(".havra-journey-chip-rail");
    if (oldRail) laneRailOffset = oldRail.scrollLeft;
    var markup = '<div class="havra-journey-title-row"><img src="' + escapeText(symbol("compass-gear-line.svg")) + '" alt=""><span>Topic Journey</span></div>' +
      '<div class="havra-journey-chip-rail">' + laneOrder.map(function (lane) {
        return '<button class="havra-journey-chip' + (lane === activeLane ? ' is-active' : '') + '" type="button" data-havra-lane="' + escapeText(lane) + '">' + escapeText(lane) + '</button>';
      }).join("") + '</div>';
    if (!oldPanel) {
      oldPanel = document.createElement("div");
      oldPanel.className = "havra-journey-panel";
      var category = header.querySelector(".category-scroll");
      if (category) header.insertBefore(oldPanel, category); else header.appendChild(oldPanel);
    }
    oldPanel.innerHTML = markup;
    var nextRail = oldPanel.querySelector(".havra-journey-chip-rail");
    keepActiveLaneVisible(nextRail);
    return true;
  }

  function laneCards() {
    if (isOriginalLane(activeLane)) return [];
    return sourceCards.filter(function (item) {
      return item.lane === activeLane && !isBlocked(item.creatorId);
    }).map(function (item) {
      ensureJourneyPost(item.postId);
      return enriched(item);
    });
  }

  function renderBrief(page) {
    var content = page && page.querySelector(".square-list-content");
    if (!content) return false;
    if (activeLane === "Photos" || activeLane === "Videos") {
      var formerBrief = content.querySelector(".havra-journey-brief");
      if (formerBrief) formerBrief.remove();
      return true;
    }
    var brief = briefMap[activeLane] || briefMap.All;
    var oldBrief = content.querySelector(".havra-journey-brief");
    if (!oldBrief) {
      oldBrief = document.createElement("div");
      oldBrief.className = "havra-journey-brief";
      content.insertBefore(oldBrief, content.firstChild);
    }
    oldBrief.style.backgroundImage = 'url("' + brief.cover + '")';
    oldBrief.innerHTML = '<div class="havra-journey-brief__copy">' +
      '<div class="havra-journey-brief__title">' + escapeText(brief.title) + '</div>' +
      '<div class="havra-journey-brief__text">' + escapeText(brief.text) + '</div>' +
      '<div class="havra-journey-brief__mark"><img src="' + escapeText(brief.icon) + '" alt=""><span>' + escapeText(brief.mark) + '</span></div>' +
    '</div>';
    return true;
  }

  function cardMarkup(item) {
    var isVlog = item.kind === "video";
    var isLiked = liked(item.postId);
    var label = isVlog ? "Vlog" : "Photo";
    return '<div class="havra-journey-card' + (item.short ? ' havra-journey-card--short' : '') + '" data-havra-card="' + escapeText(item.postId) + '">' +
      '<div class="havra-journey-card__image" style="background-image:url(&quot;' + escapeText(item.cover) + '&quot;)"></div>' +
      '<div class="havra-journey-card__badge">' + label + '</div>' +
      '<button class="havra-journey-card__more" type="button" data-havra-card-more="' + escapeText(item.postId) + '"><img src="' + escapeText(symbol("more-column.svg")) + '" alt=""></button>' +
      (isVlog ? '<div class="havra-journey-play"></div>' : '') +
      '<div class="havra-journey-card__body">' +
        '<div class="havra-journey-card__title">' + escapeText(item.title) + '</div>' +
        '<div class="havra-journey-card__meta">' +
          '<img class="havra-journey-card__avatar" src="' + escapeText(item.creatorAvatar) + '" alt="">' +
          '<div class="havra-journey-card__name">' + escapeText(item.creatorName) + '</div>' +
          '<button class="havra-journey-card__likes' + (isLiked ? ' is-active' : '') + '" type="button" data-havra-card-like="' + escapeText(item.postId) + '"><span class="havra-journey-card__heart" style="--icon-url:url(&quot;' + escapeText(symbol(isLiked ? "warm-heart-fill.svg" : "warm-heart.svg")) + '&quot;)"></span><span>' + escapeText(item.likeCount) + '</span></button>' +
        '</div>' +
      '</div>' +
    '</div>';
  }

  function renderCustomRows(page) {
    var content = page && page.querySelector(".square-list-content");
    if (!content) return false;
    var oldGrid = content.querySelector(".havra-journey-grid");
    var oldEmpty = content.querySelector(".havra-journey-empty");
    if (oldGrid) oldGrid.remove();
    if (oldEmpty) oldEmpty.remove();
    if (isOriginalLane(activeLane)) {
      page.classList.remove("havra-topic-journey-filtered");
      return true;
    }
    page.classList.add("havra-topic-journey-filtered");
    var cards = laneCards();
    var anchor = content.querySelector(".masonry-list") || null;
    if (cards.length) {
      var grid = document.createElement("div");
      grid.className = "havra-journey-grid";
      grid.innerHTML = cards.map(cardMarkup).join("");
      content.insertBefore(grid, anchor);
      return true;
    }
    var brief = briefMap[activeLane] || briefMap.All;
    var empty = document.createElement("div");
    empty.className = "havra-journey-empty";
    empty.innerHTML = '<div class="havra-journey-empty__icon-wrap"><img src="' + escapeText(brief.icon) + '" alt=""></div>' +
      '<div class="havra-journey-empty__title">No moments here yet</div>' +
      '<div class="havra-journey-empty__text">' + escapeText(brief.empty) + '</div>' +
      '<button class="havra-journey-empty__button" type="button" data-havra-share-empty>Share Moment</button>';
    content.insertBefore(empty, anchor);
    return true;
  }

  function renderAll() {
    if (renderLock) return;
    renderLock = true;
    requestAnimationFrame(function () {
      renderLock = false;
      var page = wallPage();
      if (!page) return;
      if (!retiredRowsTrimmed) {
        retiredRowsTrimmed = true;
        pruneRetiredJourneyRows();
      }
      if (lastPageNode !== page) {
        lastPageNode = page;
        domStamp = "";
      }
      var hasPanel = !!page.querySelector(".havra-journey-panel");
      var hasBrief = activeLane === "Photos" || activeLane === "Videos" || !!page.querySelector(".havra-journey-brief");
      var hasCustomRows = isOriginalLane(activeLane) || !!page.querySelector(".havra-journey-grid") || !!page.querySelector(".havra-journey-empty");
      var nextDomStamp = signature();
      if (domStamp === nextDomStamp && hasPanel && hasBrief && hasCustomRows && page.classList.contains("havra-topic-journey-mounted")) return;
      page.classList.remove("havra-topic-journey-ready", "havra-topic-journey-mounted");
      var headerReady = installHeader(page);
      var briefReady = renderBrief(page);
      var rowsReady = renderCustomRows(page);
      if (headerReady && briefReady && rowsReady) {
        page.classList.add("havra-topic-journey-mounted");
        domStamp = signature();
      } else {
        domStamp = "";
      }
      ensureOriginalLane(page);
    });
  }

  function shareMoment() {
    if (window.uni && typeof window.uni.switchTab === "function") {
      try { window.uni.switchTab({ url: "/pages/create/index" }); return; } catch (error) {}
    }
    if (window.uni && typeof window.uni.navigateTo === "function") {
      try { window.uni.navigateTo({ url: "/pages/create/index" }); return; } catch (error) {}
    }
    window.location.hash = "#/pages/create/index";
  }

  function detailReturnTarget(node) {
    if (!node || typeof node.closest !== "function") return null;
    var trigger = node.closest(".detail-header__back");
    if (!trigger) return null;
    var page = trigger.closest(".post-detail-page, .video-detail-page");
    var uniPage = trigger.closest('uni-page[data-page="pages/post-detail/index"], uni-page[data-page="pages/video-detail/index"]');
    return page || uniPage ? trigger : null;
  }

  function runDetailReturn() {
    if (window.uni && typeof window.uni.navigateBack === "function") {
      try { window.uni.navigateBack({ delta: 1 }); return; } catch (error) {}
    }
    if (window.history && window.history.length > 1) {
      window.history.back();
      return;
    }
    if (window.uni && typeof window.uni.switchTab === "function") {
      try { window.uni.switchTab({ url: "/pages/wall/index" }); return; } catch (error) {}
    }
    window.location.hash = "#/pages/wall/index";
  }

  function handleDetailReturn(event) {
    if (!detailReturnTarget(event.target)) return false;
    var now = Date.now();
    event.preventDefault();
    event.stopPropagation();
    if (now - lastDetailReturnAt < 520) return true;
    lastDetailReturnAt = now;
    runDetailReturn();
    return true;
  }

  function goPost(postId) {
    var item = sourceCards.filter(function (row) { return row.postId === postId; })[0];
    if (!item) return;
    renderJourneyDetail(postId);
  }

  function findOriginalCard(postId) {
    var state = readState();
    var post = findPost(state, postId) || {};
    var known = sourceCards.filter(function (row) { return row.postId === postId; })[0] || {};
    var needle = String(post.post_text || known.sourceText || "").slice(0, 32);
    if (!needle) return null;
    var cards = Array.prototype.slice.call(document.querySelectorAll(".square-card"));
    return cards.filter(function (card) { return card.textContent.indexOf(needle) >= 0; })[0] || null;
  }

  function tapOriginalMore(postId) {
    var card = findOriginalCard(postId);
    if (!card) return false;
    var more = card.querySelector(".square-card__more");
    if (!more) return false;
    more.dispatchEvent(new MouseEvent("click", { bubbles: true, cancelable: true, view: window }));
    return true;
  }

  function toast(text) {
    if (window.uni && typeof window.uni.showToast === "function") {
      window.uni.showToast({ title: text, icon: "none" });
      return;
    }
    var old = document.querySelector(".havra-journey-toast");
    if (old) old.remove();
    var node = document.createElement("div");
    node.className = "havra-journey-toast";
    node.textContent = text;
    document.body.appendChild(node);
    setTimeout(function () { if (node.parentNode) node.parentNode.removeChild(node); }, 1800);
  }

  function reasons() {
    var state = readState();
    var rows = Array.isArray(state.report_reason_list) ? state.report_reason_list : [];
    if (rows.length) {
      return rows.map(function (row) { return { id: row.reason_id || row.id || row.title, title: row.title || row.reason || "Inappropriate content" }; });
    }
    return [
      { id: "journey_repetitive", title: "Unwanted or repetitive content" },
      { id: "journey_disrespect", title: "Harmful or disrespectful content" },
      { id: "journey_other", title: "Other concern" }
    ];
  }

  function closeCare() {
    if (careLayer) {
      careLayer.remove();
      careLayer = null;
    }
  }

  function fallbackCare(postId) {
    ensureJourneyPost(postId);
    var state = readState();
    var item = enriched(sourceCards.filter(function (row) { return row.postId === postId; })[0] || {});
    var person = currentUser(state);
    if (item.creatorId === person.user_id) {
      toast("You cannot report yourself");
      return;
    }
    closeCare();
    var list = reasons();
    var first = list[0] ? list[0].id : "journey_other";
    careLayer = document.createElement("div");
    careLayer.className = "havra-journey-care-layer";
    careLayer.dataset.postId = postId;
    careLayer.dataset.creatorId = item.creatorId || "";
    careLayer.dataset.reasonId = first;
    careLayer.innerHTML = '<div class="havra-journey-care-dim" data-havra-care-close></div>' +
      '<div class="havra-journey-care-sheet">' +
        '<div class="havra-journey-care-handle"></div>' +
        '<h3>Report Moment</h3>' +
        '<p>Select a reason or block this profile from your Havra experience.</p>' +
        '<div class="havra-journey-care-reasons">' + list.map(function (reason, index) {
          return '<button type="button" class="havra-journey-care-reason' + (index === 0 ? ' is-active' : '') + '" data-havra-care-reason="' + escapeText(reason.id) + '"><span>' + escapeText(reason.title) + '</span><span>' + (index === 0 ? '✓' : '') + '</span></button>';
        }).join("") + '</div>' +
        '<div class="havra-journey-care-actions"><button class="havra-journey-care-primary" type="button" data-havra-care-submit>Submit Report</button><button class="havra-journey-care-soft" type="button" data-havra-care-block>Block Profile</button><button class="havra-journey-care-soft" type="button" data-havra-care-close>Cancel</button></div>' +
      '</div>';
    document.body.appendChild(careLayer);
  }

  function submitFallbackReport() {
    if (!careLayer) return;
    var state = readState();
    var person = currentUser(state);
    state.report_list = Array.isArray(state.report_list) ? state.report_list : [];
    state.report_list.unshift({
      report_id: "journey_" + Date.now().toString(36),
      user_id: person.user_id,
      reported_user_id: careLayer.dataset.creatorId,
      post_id: careLayer.dataset.postId,
      card_id: careLayer.dataset.postId,
      reason_id: careLayer.dataset.reasonId || "journey_other",
      report_context: "topic_journey",
      created_at: Date.now()
    });
    saveState(state);
    closeCare();
    toast("Report submitted");
  }

  function blockFallbackCreator() {
    if (!careLayer) return;
    var state = readState();
    var person = currentUser(state);
    var creatorId = careLayer.dataset.creatorId;
    if (creatorId === person.user_id) {
      closeCare();
      toast("You cannot report yourself");
      return;
    }
    state.block_list = Array.isArray(state.block_list) ? state.block_list : [];
    var exists = state.block_list.some(function (row) {
      return row && (row.blocked_user_id === creatorId || row.user_id === creatorId);
    });
    if (!exists) {
      state.block_list.push({
        block_id: "journey_block_" + Date.now().toString(36),
        viewer_user_id: person.user_id,
        blocked_user_id: creatorId,
        user_id: creatorId,
        block_reason: "Topic Journey",
        created_at: Date.now()
      });
    }
    saveState(state);
    closeCare();
    var activeItem = activeJourneyPostId ? findJourneyCard(activeJourneyPostId) : null;
    if (activeItem && activeItem.creatorId === creatorId) closeJourneyDetail();
    toast("Profile blocked");
    renderAll();
  }

  function openMore(postId) {
    var state = readState();
    var item = enriched(sourceCards.filter(function (row) { return row.postId === postId; })[0] || {});
    if (item.creatorId === currentUser(state).user_id) {
      toast("You cannot report yourself");
      return;
    }
    ensureJourneyPost(postId);
    fallbackCare(postId);
  }

  document.addEventListener("click", function (event) {
    if (handleDetailReturn(event)) return;
    var detailClose = event.target.closest("[data-havra-journey-detail-close]");
    if (detailClose) {
      event.preventDefault();
      event.stopPropagation();
      closeJourneyDetail();
      return;
    }
    var detailCare = event.target.closest("[data-havra-detail-care]");
    if (detailCare) {
      event.preventDefault();
      event.stopPropagation();
      openMore(detailCare.dataset.havraDetailCare);
      return;
    }
    var detailLike = event.target.closest("[data-havra-detail-like]");
    if (detailLike) {
      event.preventDefault();
      event.stopPropagation();
      var detailLikeId = detailLike.dataset.havraDetailLike;
      ensureJourneyPost(detailLikeId);
      toggleLike(detailLikeId);
      renderJourneyDetail(detailLikeId);
      setTimeout(renderAll, 80);
      return;
    }
    var detailSend = event.target.closest("[data-havra-detail-note-send]");
    if (detailSend) {
      event.preventDefault();
      event.stopPropagation();
      var detailSendId = detailSend.dataset.havraDetailNoteSend;
      var detailInput = detailLayer && detailLayer.querySelector("[data-havra-detail-note-input]");
      if (appendJourneyNote(detailSendId, detailInput ? detailInput.value : "")) {
        renderJourneyDetail(detailSendId);
        setTimeout(renderAll, 80);
      }
      return;
    }
    var laneButton = event.target.closest("[data-havra-lane]");
    if (laneButton) {
      event.preventDefault();
      event.stopPropagation();
      var laneRail = laneButton.closest(".havra-journey-chip-rail");
      if (laneRail) laneRailOffset = laneRail.scrollLeft;
      activeLane = laneButton.dataset.havraLane || "All";
      renderAll();
      return;
    }
    var shareButton = event.target.closest("[data-havra-share-empty]");
    if (shareButton) {
      event.preventDefault();
      event.stopPropagation();
      shareMoment();
      return;
    }
    var likeButton = event.target.closest("[data-havra-card-like]");
    if (likeButton) {
      event.preventDefault();
      event.stopPropagation();
      var postId = likeButton.dataset.havraCardLike;
      ensureJourneyPost(postId);
      toggleLike(postId);
      setTimeout(renderAll, 80);
      return;
    }
    var moreButton = event.target.closest("[data-havra-card-more]");
    if (moreButton) {
      event.preventDefault();
      event.stopPropagation();
      openMore(moreButton.dataset.havraCardMore);
      return;
    }
    var card = event.target.closest("[data-havra-card]");
    if (card) {
      event.preventDefault();
      event.stopPropagation();
      goPost(card.dataset.havraCard);
      return;
    }
    var reason = event.target.closest("[data-havra-care-reason]");
    if (reason && careLayer) {
      Array.prototype.slice.call(careLayer.querySelectorAll(".havra-journey-care-reason")).forEach(function (node) {
        node.classList.remove("is-active");
        var mark = node.querySelector("span:last-child");
        if (mark) mark.textContent = "";
      });
      reason.classList.add("is-active");
      var activeMark = reason.querySelector("span:last-child");
      if (activeMark) activeMark.textContent = "✓";
      careLayer.dataset.reasonId = reason.dataset.havraCareReason;
      return;
    }
    if (event.target.closest("[data-havra-care-submit]")) {
      submitFallbackReport();
      return;
    }
    if (event.target.closest("[data-havra-care-block]")) {
      blockFallbackCreator();
      return;
    }
    if (event.target.closest("[data-havra-care-close]")) {
      closeCare();
      return;
    }
  }, true);

  document.addEventListener("keydown", function (event) {
    var input = event.target && event.target.closest ? event.target.closest("[data-havra-detail-note-input]") : null;
    if (!input || event.key !== "Enter") return;
    event.preventDefault();
    if (appendJourneyNote(activeJourneyPostId, input.value)) {
      renderJourneyDetail(activeJourneyPostId);
      setTimeout(renderAll, 80);
    }
  }, true);

  document.addEventListener("touchend", function (event) {
    handleDetailReturn(event);
  }, true);

  function signature() {
    var state = readState();
    var blocks = Array.isArray(state.block_list) ? state.block_list.map(function (row) { return row && (row.blocked_user_id || row.user_id || row.block_id); }).join("|") : "";
    var likes = Array.isArray(state.pet_post_like_list) ? state.pet_post_like_list.map(function (row) { return row && row.user_id + ":" + row.post_id; }).sort().join("|") : "";
    return activeLane + "::" + blocks + "::" + likes;
  }

  function schedule() {
    renderAll();
  }

  var target = document.getElementById("app") || document.body;
  new MutationObserver(function () { schedule(); }).observe(target, { childList: true, subtree: true });
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", schedule); else schedule();
  setInterval(function () {
    var nextStamp = signature();
    if (nextStamp !== guardStamp) {
      guardStamp = nextStamp;
      renderAll();
    }
  }, 750);
})();
