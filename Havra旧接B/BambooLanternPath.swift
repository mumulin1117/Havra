// BambooLanternPath.swift
// Havra · B module

import Foundation

private struct HavraBRequestFieldMapping {
    let deviceID: String
    let appVersion: String
    let pushToken: String
    let acknowledgment: String
    let transactionID: String
    let receipt: String
    let orderID: String
}

private struct HavraBResponseFieldMapping {
    let pageURL: String
    let credential: String
    let channel: String
    let socketURL: String
    let credentialToken: String
}

private struct HavraBIncomingMessageMapping {
    let data: String
    let purchaseSelector: String
    let closeSelector: String
    let openSelector: String
    let forwardSelector: String
    let productID: String
    let orderID: String
    let externalURL: String
    let directCloseHandler: String
}

private struct HavraBOutgoingMessageMapping {
    let event: String
    let orderID: String
    let productID: String
    let success: String
    let status: String
    let message: String
    let reason: String
    let openEvent: String
    let openState: String
    let source: String
    let nativeSource: String
}

private struct HavraBEventNames {
    let purchase: String
    let close: String
    let open: String
    let purchaseResult: String
    let forward: String
}

private struct HavraBEnvironmentConfiguration {
    let baseURL: URL
    let openPath: String
    let receiptVerificationPath: String
    let requestFields: HavraBRequestFieldMapping
    let responseFields: HavraBResponseFieldMapping
    let incomingMessages: HavraBIncomingMessageMapping
    let outgoingMessages: HavraBOutgoingMessageMapping
    let events: HavraBEventNames
}

/// Havra B 模块当前仅接入参考项目的测试协议。
/// 正式服务必须在提供 Havra 专属域名和整套字段后单独配置。
enum HavraBConfiguration {
    enum Environment {
        // 当前固定使用已确认的测试环境；此值同时控制测试诊断与存储隔离。
        static let isDebug = true
        static var apiBaseURL: URL { HavraBConfiguration.current.baseURL }
    }

    // 与参考项目当前启用的测试协议保持一致。
    private static let test = HavraBEnvironmentConfiguration(
        baseURL: URL(string: "https://api.zwwtesttop.top")!,
        openPath: "/app/open",
        receiptVerificationPath: "/app/p",
        requestFields: HavraBRequestFieldMapping(
            deviceID: "deviceNo",
            appVersion: "appVersion",
            pushToken: "pushToken",
            acknowledgment: "roomPushMsgType",
            transactionID: "transactionId",
            receipt: "payload",
            orderID: "callbackResult"
        ),
        responseFields: HavraBResponseFieldMapping(
            pageURL: "h5Url",
            credential: "tokenResult",
            channel: "roomId",
            socketURL: "webSocketUrl",
            credentialToken: "token"
        ),
        incomingMessages: HavraBIncomingMessageMapping(
            data: "data",
            purchaseSelector: "event",
            closeSelector: "event",
            openSelector: "event",
            forwardSelector: "event",
            productID: "batchNo",
            orderID: "orderCode",
            externalURL: "openUrl",
            directCloseHandler: "Close"
        ),
        outgoingMessages: HavraBOutgoingMessageMapping(
            event: "event",
            orderID: "callbackResult",
            productID: "productId",
            success: "success",
            status: "status",
            message: "message",
            reason: "reason",
            openEvent: "nativeOpenState",
            openState: "state",
            source: "source",
            nativeSource: "native"
        ),
        events: HavraBEventNames(
            purchase: "pay",
            close: "logout",
            open: "openBrowser",
            purchaseResult: "payResult",
            forward: "linkSuccessMessage"
        )
    )
    private static let normal = HavraBEnvironmentConfiguration(
        baseURL: URL(string: "https://havr.r4k0g5sx.link")!,
        openPath: "/havra/saungGaukCurve",
        receiptVerificationPath: "/havra/kheneBambooTone",
        requestFields: HavraBRequestFieldMapping(
            deviceID: "templeCourtyardCalm",
            appVersion: "steelTiffinStack",
            pushToken: "HavraBatikGlyphs",
            acknowledgment: "fabricBoltStack",
            transactionID: "ikatWeaveDetail",
            receipt: "batikWaxLine",
            orderID: "stallNumberBoard"
        ),
        responseFields: HavraBResponseFieldMapping(
            pageURL: "riceHarvestCeremony",
            credential: "midAutumnLantern",
            channel: "drySeasonDustPath",
            socketURL: "rattanChairShade",
            credentialToken: "token"
        ),
        incomingMessages: HavraBIncomingMessageMapping(
            data: "data",
            purchaseSelector: "baganDustLight",
            closeSelector: "pasarMorningFlow",
            openSelector: "kopitiamTableScene",
            forwardSelector: "batamFerryGate",
            productID: "redRiverLane",
            orderID: "mekongDeltaMorning",
            externalURL: "jeepneyColorLine",
            directCloseHandler: "Close"
        ),
        outgoingMessages: HavraBOutgoingMessageMapping(
            event: "event",
            orderID: "callbackResult",
            productID: "productId",
            success: "success",
            status: "status",
            message: "message",
            reason: "reason",
            openEvent: "nativeOpenState",
            openState: "state",
            source: "source",
            nativeSource: "native"
        ),
        events: HavraBEventNames(
            purchase: "angkorStonePath",
            close: "hawkerStallRhythm",
            open: "warungKitchenMood",
            purchaseResult: "payResult",
            forward: "krabiCliffMorning"
        )
    )
    private static var current: HavraBEnvironmentConfiguration {Environment.isDebug ? test : normal }
    
    // 网络、WebView 和支付模块共用同一套协议映射。
    enum API {
        static var bootstrapPath: String { current.openPath }
        static var confirmationPath: String { current.receiptVerificationPath }
        static let method = "POST"
        static let timeout: TimeInterval = 20
        static let fallbackAppVersion = "1.0"
        enum Request {
            private static var fields: HavraBRequestFieldMapping { current.requestFields }
            static var deviceID: String { fields.deviceID }
            static var appVersion: String { fields.appVersion }
            static var pushToken: String { fields.pushToken }
            static var acknowledgment: String { fields.acknowledgment }
            static let acknowledgmentValue = 2
            static var transactionID: String { fields.transactionID }
            static var receipt: String { fields.receipt }
            static var orderID: String { fields.orderID }
        }
        enum Response {
            private static var fields: HavraBResponseFieldMapping { current.responseFields }
            static var pageURL: String { fields.pageURL }
            static var channel: String { fields.channel }
            static var socketURL: String { fields.socketURL }
            static var credential: String { fields.credential }
            static var credentialToken: String { fields.credentialToken }
        }
        // 测试验单接口以空 JSON 对象 {} 表示确认成功。
        static func acceptsConfirmation(_ payload: [String: Any]) -> Bool { payload.isEmpty }
    }

    enum Bridge {
        private static var fields: HavraBIncomingMessageMapping { current.incomingMessages }
        static var data: String { fields.data }
        static var purchaseSelector: String { fields.purchaseSelector }
        static var purchaseAction: String { current.events.purchase }
        static var closeSelector: String { fields.closeSelector }
        static var closeAction: String { current.events.close }
        static var openSelector: String { fields.openSelector }
        static var openAction: String { current.events.open }
        static var forwardSelector: String { fields.forwardSelector }
        static var forwardAction: String { current.events.forward }
        static var directCloseHandler: String { fields.directCloseHandler }
        static var productID: String { fields.productID }
        static var orderID: String { fields.orderID }
        static var externalURL: String { fields.externalURL }
    }

    enum Callback {
        private static var fields: HavraBOutgoingMessageMapping { current.outgoingMessages }
        static var event: String { fields.event }
        static var purchaseEvent: String { current.events.purchaseResult }
        static var orderID: String { fields.orderID }
        static var productID: String { fields.productID }
        static var success: String { fields.success }
        static var status: String { fields.status }
        static var message: String { fields.message }
        static var reason: String { fields.reason }
        static var openEvent: String { fields.openEvent }
        static var openState: String { fields.openState }
        static var source: String { fields.source }
        static var nativeSource: String { fields.nativeSource }
        // verified/pending/failed/cancelled 等支付状态值继续使用原有状态机约定。
    }

    enum Diagnostics {
        static let startupLogsEnabled = Environment.isDebug
        static func startup(_ metric: String, value: Any? = nil) {
            guard startupLogsEnabled else { return }
            print("[Havra B startup] \(metric)\(value.map { "=\($0)" } ?? "")")
        }
        static func elapsed(_ metric: String, since start: TimeInterval) {
            guard startupLogsEnabled else { return }
            startup(metric, value: (ProcessInfo.processInfo.systemUptime - start) * 1000)
        }
    }

    // 原生能力、项目资源与持久化命名空间。
    enum Network {
        static let pageSchemes = ["https", "http"]
        static let socketSchemes = ["wss", "ws"]
        static let externalSchemes = ["https", "http", "itms-apps"]
        // Ably 固定协议；域名白名单不能改为任意域名放行，更换服务商时还需适配消息协议。
        static let socketHosts = ["realtime.ably.io", "realtime.ably.com"]
        static let socketCredentialQueryNames = ["accessToken", "key"]
        static let socketTokenQueryName = "accessToken"
    }

    enum Storage {
        // 使用 Havra 独立的测试订单空间，不读取参考 App 的用户数据。
        static let legacySharedStateKey = "havra.FerryHarborRoute"
        static let productionPurchaseRecordsKey = legacySharedStateKey
        static let testPurchaseRecordsKey = "havra.FerryHarborRoute.debug"
        static var purchaseRecordsKey: String { Environment.isDebug ? testPurchaseRecordsKey : productionPurchaseRecordsKey }
        // 入口状态与订单使用独立键，防止退出时覆盖待确认订单。
        static var stateKey: String { Environment.isDebug ? "havra.FerryHarborRoute.entry.debug" : "havra.FerryHarborRoute.entry" }
        static func entryState(in defaults: UserDefaults = .standard) -> Bool {
            if let value = defaults.object(forKey: stateKey) as? Bool { return value }
            // 只兼容旧布尔状态；旧键里的订单 Data 保持原样，不删除、不覆盖。
            let value = defaults.object(forKey: legacySharedStateKey) as? Bool ?? true
            defaults.set(value, forKey: stateKey)
            return value
        }
        static let pushTokenKey = "havra.pushToken"
        // 设备标识使用 Havra 的实际 Bundle ID 和独立 Keychain 账户。
        static let fallbackBundleID = "com.enliq.havra"
        static let legacyFallbackBundleID = "com.havra"
        static let legacyServiceSuffix = ".havra"
        static let deviceAccountSuffix = ".havra.device"
        static let legacyDeviceAccountSuffix = ".havra.device.id"
        // 使用 Havra 的 App ID，避免继承参考项目的固定身份。
        static let deviceIDSuffix = "75843264"
    }

    enum Presentation {
        // 复用 Havra 已有的启动图。
        static let loadingBackground = "lanugchHavra"
        static let fallbackBackground = "lanugchHavra"
        static let purchaseAccessibilityID = "havra.purchase.notice"
        // 保留测试 B 页约定的安全区 CSS 变量名。
        static let safeAreaTopCSS = "--cozyBackgroundDollnoro"
        static let safeAreaBottomCSS = "--winterBackgroundDollpavo"
    }
}


// Wire fields and persisted keys retain their existing values.
enum BambooLanternPath {
    static let apiURL = HavraBConfiguration.Environment.apiBaseURL
    static let bootstrapPath = HavraBConfiguration.API.bootstrapPath
    static let confirmationPath = HavraBConfiguration.API.confirmationPath
    static let stateKey = HavraBConfiguration.Storage.stateKey
    static let pushKey = HavraBConfiguration.Storage.pushTokenKey
    static let close = HavraBConfiguration.Bridge.closeAction

    static func text(_ value: Any?) -> String? {
        guard let value = value as? String else { return nil }
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    static func dictionary(_ value: Any?) -> [String: Any]? {
        if let value = value as? [String: Any] { return value }
        guard let value = value as? String, let data = value.data(using: .utf8) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
    }

    static func sameOrigin(_ lhs: URL, _ rhs: URL) -> Bool {
        func port(_ url: URL) -> Int { url.port ?? (url.scheme == "https" ? 443 : 80) }
        return lhs.scheme?.lowercased() == rhs.scheme?.lowercased()
            && lhs.host?.lowercased() == rhs.host?.lowercased() && port(lhs) == port(rhs)
    }

    static func action(_ payload: [String: Any]) -> String? {
        typealias B = HavraBConfiguration.Bridge
        let fields = [(B.purchaseSelector, B.purchaseAction), (B.closeSelector, close),
                      (B.openSelector, B.openAction), (B.forwardSelector, B.forwardAction)]
        let matches = fields.filter { text(payload[$0.0]) == $0.1 }
        return matches.count == 1 ? matches.first?.1 : nil
    }

    static func externalURL(_ value: Any?) -> URL? {
        guard var value = text(value) else { return nil }
        if value.hasPrefix("["), value.hasSuffix(")"), let range = value.range(of: "](", options: .backwards) {
            value = String(value[range.upperBound...].dropLast())
        }
        return text(value).flatMap(URL.init(string:))
    }

    static func purchaseResult(order: String, product: String, status: String, message: String,
                               reason: String? = nil) -> [String: Any] {
        typealias C = HavraBConfiguration.Callback
        var payload: [String: Any] = [C.event: C.purchaseEvent, C.orderID: order, C.productID: product,
                                    C.success: status == "verified", C.status: status, C.message: message]
        if let reason { payload[C.reason] = reason }
        return payload
    }
}

struct HavraBEntryConfiguration {
    let pageURL: URL
    let channel: String
    let socketURL: URL

    static func stellarFeelingTrail(springAffinityCanvas payload: [String: Any]) throws -> Self? {
        typealias R = HavraBConfiguration.API.Response
        typealias N = HavraBConfiguration.Network
        guard let value = payload[R.pageURL], !(value is NSNull) else { return nil }
        if let value = value as? String, BambooLanternPath.text(value) == nil { return nil }
        guard let page = BambooLanternPath.text(value), let pageURL = URL(string: page),
              N.pageSchemes.contains(pageURL.scheme?.lowercased() ?? ""), pageURL.host != nil,
              let channel = BambooLanternPath.text(payload[R.channel]),
              let socket = BambooLanternPath.text(payload[R.socketURL]),
              var components = URLComponents(string: socket),
              N.socketSchemes.contains(components.scheme?.lowercased() ?? ""),
              let host = components.host?.lowercased(),
              N.socketHosts.contains(where: { host == $0 || host.hasSuffix("." + $0) })
        else { throw HavraBConnectionError.summerInspirationCanvas }
        let tokenValue = payload[R.credential]
        let token = BambooLanternPath.dictionary(tokenValue).map { BambooLanternPath.text($0[R.credentialToken]) }
            ?? BambooLanternPath.text(tokenValue)
        var query = components.queryItems ?? []
        if !query.contains(where: { N.socketCredentialQueryNames.contains($0.name) && !($0.value ?? "").isEmpty }) {
            guard let token else { throw HavraBConnectionError.summerInspirationCanvas }
            query.append(URLQueryItem(name: N.socketTokenQueryName, value: token))
        }
        query.removeAll { $0.name == "format" }
        components.queryItems = query + [URLQueryItem(name: "format", value: "json")]
        guard let socketURL = components.url else { throw HavraBConnectionError.summerInspirationCanvas }
        return Self(pageURL: pageURL, channel: channel, socketURL: socketURL)
    }
}

enum HavraBConnectionError: LocalizedError {
    case summerImaginationCanvas, summerInspirationCanvas, summerReflectionCanvas
    var errorDescription: String? {
        switch self {
        case .summerImaginationCanvas: return "Unable to connect. Please try again."
        case .summerInspirationCanvas: return "The connection details are incomplete. Please try again later."
        case .summerReflectionCanvas: return "Your purchase is awaiting confirmation. Please try again later."
        }
    }
}
