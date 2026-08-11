import Foundation

enum HavraAtlasPathGuide {
    static func foldedAtlasPath(_ path: String) -> String {
        var pathSegments: [String] = []
        for segment in path.split(separator: "/", omittingEmptySubsequences: true) {
            switch segment {
            case ".":
                continue
            case "..":
                if !pathSegments.isEmpty {
                    pathSegments.removeLast()
                }
            default:
                pathSegments.append(String(segment))
            }
        }
        return pathSegments.joined(separator: "/")
    }

    static func atlasPath(for relativePath: String) -> String {
        let routeAliases = [
            ("assets/", "havra-entry/"),
            ("static/add/", "havra-atlas/publish-kit/"),
            ("static/assets/head/", "havra-atlas/visual-set/profile-faces/"),
            ("static/assets/icons/", "havra-atlas/visual-set/interface-symbols/"),
            ("static/assets/img/", "havra-atlas/visual-set/scene-stills/"),
            ("static/assets/tabbar/", "havra-atlas/visual-set/journey-tabs/"),
            ("static/assets/video/", "havra-atlas/visual-set/story-reels/"),
            ("static/assets/", "havra-atlas/visual-set/"),
            ("static/common.config/", "havra-atlas/catalog-config/"),
            ("static/icon/", "havra-atlas/navigation-symbols/"),
            ("static/", "havra-atlas/")
        ]

        var atlasPath = relativePath
        for (legacyPrefix, atlasPrefix) in routeAliases where relativePath.hasPrefix(legacyPrefix) {
            atlasPath = atlasPrefix + String(relativePath.dropFirst(legacyPrefix.count))
            break
        }

        let ledgerAliases = [
            "havra-atlas/catalog-config/coin-packages.json": "havra-atlas/catalog-config/harvest-ledger.json"
        ]

        if let ledgerPath = ledgerAliases[atlasPath] {
            return ledgerPath
        }

        let sceneStillAliases = [
            "havra-atlas/visual-set/scene-stills/img_1.png": "havra-atlas/visual-set/scene-stills/river-market-morning.png",
            "havra-atlas/visual-set/scene-stills/img_2.png": "havra-atlas/visual-set/scene-stills/lantern-evening-lane.png",
            "havra-atlas/visual-set/scene-stills/img_3.png": "havra-atlas/visual-set/scene-stills/cebu-bright-shore.png",
            "havra-atlas/visual-set/scene-stills/img_4.png": "havra-atlas/visual-set/scene-stills/bali-cafe-shade.png",
            "havra-atlas/visual-set/scene-stills/img_5.png": "havra-atlas/visual-set/scene-stills/hanoi-lunch-stall.png",
            "havra-atlas/visual-set/scene-stills/img_6.png": "havra-atlas/visual-set/scene-stills/manila-sunset-walk.png",
            "havra-atlas/visual-set/scene-stills/img_7.png": "havra-atlas/visual-set/scene-stills/penang-craft-lane.png",
            "havra-atlas/visual-set/scene-stills/img_8.png": "havra-atlas/visual-set/scene-stills/orchid-stall-detail.png",
            "havra-atlas/visual-set/scene-stills/img_9.png": "havra-atlas/visual-set/scene-stills/ferry-daylight-route.png",
            "havra-atlas/visual-set/scene-stills/img_10.png": "havra-atlas/visual-set/scene-stills/family-table-spread.png",
            "havra-atlas/visual-set/scene-stills/img_11.png": "havra-atlas/visual-set/scene-stills/festival-lantern-row.png",
            "havra-atlas/visual-set/scene-stills/img_12.png": "havra-atlas/visual-set/scene-stills/fashion-street-color.png",
            "havra-atlas/visual-set/scene-stills/img_13.png": "havra-atlas/visual-set/scene-stills/courtyard-game-day.png",
            "havra-atlas/visual-set/scene-stills/img_14.png": "havra-atlas/visual-set/scene-stills/harbor-ferry-seat.png",
            "havra-atlas/visual-set/scene-stills/img_15.png": "havra-atlas/visual-set/scene-stills/rainy-shopfront-walk.png"
        ]

        if let scenePath = sceneStillAliases[atlasPath] {
            return scenePath
        }

        let compassAliases = [
            "havra-atlas/navigation-symbols/msg.png": "havra-atlas/navigation-symbols/note-leaf.png",
            "havra-atlas/navigation-symbols/folloew.png": "havra-atlas/navigation-symbols/trail-link.png",
            "havra-atlas/navigation-symbols/album.png": "havra-atlas/navigation-symbols/memory-grid.png",
            "havra-atlas/navigation-symbols/his.png": "havra-atlas/navigation-symbols/journey-log.png",
            "havra-atlas/navigation-symbols/coin.png": "havra-atlas/navigation-symbols/harvest-disc.png",
            "havra-atlas/navigation-symbols/setting.png": "havra-atlas/navigation-symbols/compass-gear.png",
            "havra-atlas/navigation-symbols/home_add.png": "havra-atlas/navigation-symbols/doorway-plus.png",
            "havra-atlas/navigation-symbols/home_like.svg": "havra-atlas/navigation-symbols/hearth-outline.svg",
            "havra-atlas/navigation-symbols/home_like_filled.svg": "havra-atlas/navigation-symbols/hearth-filled.svg",
            "havra-atlas/navigation-symbols/like.png": "havra-atlas/navigation-symbols/heart-outline.png",
            "havra-atlas/navigation-symbols/liked.png": "havra-atlas/navigation-symbols/heart-filled.png"
        ]

        if let compassPath = compassAliases[atlasPath] {
            return compassPath
        }

        let craftAliases = [
            "havra-atlas/publish-kit/chat_send.png": "havra-atlas/publish-kit/note-dispatch.png",
            "havra-atlas/publish-kit/chat_video.png": "havra-atlas/publish-kit/story-frame.png",
            "havra-atlas/publish-kit/create_picture.png": "havra-atlas/publish-kit/compose-still.png",
            "havra-atlas/publish-kit/create_video.png": "havra-atlas/publish-kit/compose-reel.png",
            "havra-atlas/publish-kit/gold.png": "havra-atlas/publish-kit/sun-disc.png",
            "havra-atlas/publish-kit/his_charge.png": "havra-atlas/publish-kit/ledger-sunrise.png",
            "havra-atlas/publish-kit/his_video.png": "havra-atlas/publish-kit/story-ledger.png",
            "havra-atlas/publish-kit/home_like.png": "havra-atlas/publish-kit/trail-heart-outline.png",
            "havra-atlas/publish-kit/home_liked.png": "havra-atlas/publish-kit/trail-heart-filled.png",
            "havra-atlas/publish-kit/home_reort.png": "havra-atlas/publish-kit/care-flag.png",
            "havra-atlas/publish-kit/publish_picture.png": "havra-atlas/publish-kit/atlas-still-ready.png",
            "havra-atlas/publish-kit/publish_video.png": "havra-atlas/publish-kit/atlas-reel-ready.png",
            "havra-atlas/publish-kit/tag_1.png": "havra-atlas/publish-kit/street-bowl.png",
            "havra-atlas/publish-kit/tag_2.png": "havra-atlas/publish-kit/cafe-cup.png",
            "havra-atlas/publish-kit/tag_3.png": "havra-atlas/publish-kit/market-basket.png",
            "havra-atlas/publish-kit/tag_4.png": "havra-atlas/publish-kit/heritage-lantern.png",
            "havra-atlas/publish-kit/tag_5.png": "havra-atlas/publish-kit/green-trail.png",
            "havra-atlas/publish-kit/tag_6.png": "havra-atlas/publish-kit/weekend-map.png",
            "havra-atlas/publish-kit/tag_7.png": "havra-atlas/publish-kit/neighbor-hands.png",
            "havra-atlas/publish-kit/tag_8.png": "havra-atlas/publish-kit/quiet-gem.png",
            "havra-atlas/publish-kit/tag_9.png": "havra-atlas/publish-kit/easy-breeze.png",
            "havra-atlas/publish-kit/tag_10.png": "havra-atlas/publish-kit/joy-sun.png",
            "havra-atlas/publish-kit/tag_11.png": "havra-atlas/publish-kit/curiosity-compass.png",
            "havra-atlas/publish-kit/tag_12.png": "havra-atlas/publish-kit/inspired-spark.png",
            "havra-atlas/publish-kit/tag_13.png": "havra-atlas/publish-kit/warm-circle.png",
            "havra-atlas/publish-kit/tag_14.png": "havra-atlas/publish-kit/mindful-leaf.png"
        ]

        if let craftPath = craftAliases[atlasPath] {
            return craftPath
        }

        let markAliases = [
            "havra-atlas/visual-set/interface-symbols/bell.svg": "havra-atlas/visual-set/interface-symbols/chime-mark.svg",
            "havra-atlas/visual-set/interface-symbols/block.svg": "havra-atlas/visual-set/interface-symbols/safety-barrier.svg",
            "havra-atlas/visual-set/interface-symbols/bookmark-fill.svg": "havra-atlas/visual-set/interface-symbols/saved-ribbon-fill.svg",
            "havra-atlas/visual-set/interface-symbols/bookmark.svg": "havra-atlas/visual-set/interface-symbols/saved-ribbon.svg",
            "havra-atlas/visual-set/interface-symbols/camera-video.svg": "havra-atlas/visual-set/interface-symbols/story-lens.svg",
            "havra-atlas/visual-set/interface-symbols/camera.svg": "havra-atlas/visual-set/interface-symbols/still-lens.svg",
            "havra-atlas/visual-set/interface-symbols/chat.svg": "havra-atlas/visual-set/interface-symbols/note-bubble.svg",
            "havra-atlas/visual-set/interface-symbols/check.svg": "havra-atlas/visual-set/interface-symbols/tick-mark.svg",
            "havra-atlas/visual-set/interface-symbols/chevron-left.svg": "havra-atlas/visual-set/interface-symbols/back-chevron.svg",
            "havra-atlas/visual-set/interface-symbols/close.svg": "havra-atlas/visual-set/interface-symbols/close-cross.svg",
            "havra-atlas/visual-set/interface-symbols/coin-history.svg": "havra-atlas/visual-set/interface-symbols/ledger-clock.svg",
            "havra-atlas/visual-set/interface-symbols/coin.svg": "havra-atlas/visual-set/interface-symbols/sun-medallion.svg",
            "havra-atlas/visual-set/interface-symbols/delete.svg": "havra-atlas/visual-set/interface-symbols/remove-mark.svg",
            "havra-atlas/visual-set/interface-symbols/edit.svg": "havra-atlas/visual-set/interface-symbols/refine-pencil.svg",
            "havra-atlas/visual-set/interface-symbols/follow.svg": "havra-atlas/visual-set/interface-symbols/trail-plus.svg",
            "havra-atlas/visual-set/interface-symbols/followers.svg": "havra-atlas/visual-set/interface-symbols/trail-cluster.svg",
            "havra-atlas/visual-set/interface-symbols/heart-fill.svg": "havra-atlas/visual-set/interface-symbols/warm-heart-fill.svg",
            "havra-atlas/visual-set/interface-symbols/heart.svg": "havra-atlas/visual-set/interface-symbols/warm-heart.svg",
            "havra-atlas/visual-set/interface-symbols/home_selected.svg": "havra-atlas/visual-set/interface-symbols/entry-selected.svg",
            "havra-atlas/visual-set/interface-symbols/lock.svg": "havra-atlas/visual-set/interface-symbols/privacy-lock.svg",
            "havra-atlas/visual-set/interface-symbols/messages.svg": "havra-atlas/visual-set/interface-symbols/note-stack.svg",
            "havra-atlas/visual-set/interface-symbols/mic.svg": "havra-atlas/visual-set/interface-symbols/voice-mark.svg",
            "havra-atlas/visual-set/interface-symbols/more-horizontal.svg": "havra-atlas/visual-set/interface-symbols/more-row.svg",
            "havra-atlas/visual-set/interface-symbols/more-vertical.svg": "havra-atlas/visual-set/interface-symbols/more-column.svg",
            "havra-atlas/visual-set/interface-symbols/nav-album.svg": "havra-atlas/visual-set/interface-symbols/keepsake-grid.svg",
            "havra-atlas/visual-set/interface-symbols/nav-create.svg": "havra-atlas/visual-set/interface-symbols/compose-plus.svg",
            "havra-atlas/visual-set/interface-symbols/nav-home.svg": "havra-atlas/visual-set/interface-symbols/entry-way.svg",
            "havra-atlas/visual-set/interface-symbols/nav-profile.svg": "havra-atlas/visual-set/interface-symbols/person-mark.svg",
            "havra-atlas/visual-set/interface-symbols/nav-square.svg": "havra-atlas/visual-set/interface-symbols/plaza-grid.svg",
            "havra-atlas/visual-set/interface-symbols/paw.svg": "havra-atlas/visual-set/interface-symbols/leaf-print.svg",
            "havra-atlas/visual-set/interface-symbols/phone.svg": "havra-atlas/visual-set/interface-symbols/contact-handset.svg",
            "havra-atlas/visual-set/interface-symbols/photo-library.svg": "havra-atlas/visual-set/interface-symbols/still-collection.svg",
            "havra-atlas/visual-set/interface-symbols/report.svg": "havra-atlas/visual-set/interface-symbols/care-flag-line.svg",
            "havra-atlas/visual-set/interface-symbols/search.svg": "havra-atlas/visual-set/interface-symbols/find-lens.svg",
            "havra-atlas/visual-set/interface-symbols/send.svg": "havra-atlas/visual-set/interface-symbols/dispatch-arrow.svg",
            "havra-atlas/visual-set/interface-symbols/settings.svg": "havra-atlas/visual-set/interface-symbols/compass-gear-line.svg"
        ]

        if let markPath = markAliases[atlasPath] {
            return markPath
        }

        let journeyAliases = [
            "havra-atlas/visual-set/journey-tabs/home-active.svg": "havra-atlas/visual-set/journey-tabs/entry-lit.svg",
            "havra-atlas/visual-set/journey-tabs/home-default.svg": "havra-atlas/visual-set/journey-tabs/entry-rest.svg",
            "havra-atlas/visual-set/journey-tabs/library-active.svg": "havra-atlas/visual-set/journey-tabs/atlas-lit.svg",
            "havra-atlas/visual-set/journey-tabs/library-default.svg": "havra-atlas/visual-set/journey-tabs/atlas-rest.svg",
            "havra-atlas/visual-set/journey-tabs/profile-active.svg": "havra-atlas/visual-set/journey-tabs/self-lit.svg",
            "havra-atlas/visual-set/journey-tabs/profile-default.svg": "havra-atlas/visual-set/journey-tabs/self-rest.svg",
            "havra-atlas/visual-set/journey-tabs/wall-active.svg": "havra-atlas/visual-set/journey-tabs/plaza-lit.svg",
            "havra-atlas/visual-set/journey-tabs/wall-default.svg": "havra-atlas/visual-set/journey-tabs/plaza-rest.svg"
        ]

        if let journeyPath = journeyAliases[atlasPath] {
            return journeyPath
        }

        let portraitAliases = [
            "havra-atlas/visual-set/profile-faces/head_1.png": "havra-atlas/visual-set/profile-faces/face-bangkok-guide.png",
            "havra-atlas/visual-set/profile-faces/head_2.png": "havra-atlas/visual-set/profile-faces/face-bali-morning.png",
            "havra-atlas/visual-set/profile-faces/head_3.png": "havra-atlas/visual-set/profile-faces/face-hanoi-reader.png",
            "havra-atlas/visual-set/profile-faces/head_4.png": "havra-atlas/visual-set/profile-faces/face-manila-sunset.png",
            "havra-atlas/visual-set/profile-faces/head_5.png": "havra-atlas/visual-set/profile-faces/face-bangkok-lane.png",
            "havra-atlas/visual-set/profile-faces/head_6.png": "havra-atlas/visual-set/profile-faces/face-penang-craft.png",
            "havra-atlas/visual-set/profile-faces/head_7.png": "havra-atlas/visual-set/profile-faces/face-cebu-shore.png",
            "havra-atlas/visual-set/profile-faces/head_8.png": "havra-atlas/visual-set/profile-faces/face-lantern-walk.png",
            "havra-atlas/visual-set/profile-faces/head_9.png": "havra-atlas/visual-set/profile-faces/face-market-smile.png",
            "havra-atlas/visual-set/profile-faces/head_10.png": "havra-atlas/visual-set/profile-faces/face-ferry-seat.png",
            "havra-atlas/visual-set/profile-faces/head_11.png": "havra-atlas/visual-set/profile-faces/face-family-table.png",
            "havra-atlas/visual-set/profile-faces/head_12.png": "havra-atlas/visual-set/profile-faces/face-festival-light.png",
            "havra-atlas/visual-set/profile-faces/head_13.png": "havra-atlas/visual-set/profile-faces/face-fashion-corner.png",
            "havra-atlas/visual-set/profile-faces/head_14.png": "havra-atlas/visual-set/profile-faces/face-rainy-shopfront.png"
        ]

        return portraitAliases[atlasPath] ?? atlasPath
    }
}
