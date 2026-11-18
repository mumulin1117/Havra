import CoreFoundation
import Foundation

enum HavraLifeLaunch {
    static let appID = "75843264"
    static let service = URL(string: "https://www.havraaurora.store")!
    static let welcomeHost = "pub-502fe258836144a6bf68cc5c21be65e0.r2.dev"
    private static let startup = service.appendingPathComponent("casual9/daily/feelings/people/daily")
    private static let tokenService = URL(string: "https://main.realtime.ably.net")!

    struct Identity {
        let deviceID: String
        let version: String
        let pushToken: String?

        static func current() -> Self {
            let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
            let token = BambooLanternPath.text(UserDefaults.standard.string(forKey: BambooLanternPath.pushKey))
            return Self(deviceID: OrdinaryCityDay.dawnImaginationCanvas(),
                        version: version ?? "1.0", pushToken: token)
        }

        func registrationURL(_ file: URL) -> URL? {
            guard var address = URLComponents(url: file, resolvingAgainstBaseURL: false) else { return nil }
            address.queryItems = [
                URLQueryItem(name: "appId", value: HavraLifeLaunch.appID),
                URLQueryItem(name: "appVersion", value: version),
                URLQueryItem(name: "deviceId", value: deviceID)
            ]
            if let pushToken { address.queryItems?.append(URLQueryItem(name: "pushToken", value: pushToken)) }
            address.fragment = "/"
            return address.url
        }
    }

    enum Page: String {
        case welcome = "Havrawelcome"
        case community = "Havracommunity"
    }

    struct Reply {
        let url: URL
        let fields: [String: Any]

        var page: Page? { HavraLifeLaunch.onboardingPage(url) }
        var credential: [String: Any]? {
            BambooLanternPath.dictionary(fields["videoBondTopics"] ?? fields["longtoken"])
        }
    }

    static func openAtStartup() async throws -> Reply {
        while true {
            try Task.checkCancellation()
            do {
                return try await open(identity: .current())
            } catch {
                try await Task.sleep(nanoseconds: 1_500_000_000)
            }
        }
    }

    static func open(identity: Identity, session: URLSession = .shared) async throws -> Reply {
        var request = URLRequest(url: startup, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 18)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appID, forHTTPHeaderField: "followRegionalBrowse")
        request.setValue(identity.version, forHTTPHeaderField: "voicesMomentsMemory")
        request.setValue(identity.deviceID, forHTTPHeaderField: "sharingAuthenticMemory")
        var body: [String: String] = [:]
        body["companionsHarmonySharing"] = identity.pushToken
        request.httpBody = try JSONEncoder().encode(body)
        let (data, response) = try await session.data(for: request)
        try Task.checkCancellation()
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw HavraBConnectionError.summerImaginationCanvas
        }
        let document = try JSONSerialization.jsonObject(with: data)
        guard let fields = document as? [String: Any],
              let code = (fields["momentsAuthenticFollow"] ?? fields["code"]) as? NSNumber,
              CFGetTypeID(code) != CFBooleanGetTypeID(), code.doubleValue == 0,
              let rawURL = BambooLanternPath.text(fields["photosLocalCompanions"] ?? fields["h5Url"]),
              let url = httpsURL(rawURL) else {
            throw HavraBConnectionError.summerInspirationCanvas
        }
        return Reply(url: url, fields: fields)
    }

    static func httpsURL(_ value: String) -> URL? {
        guard !value.isEmpty, value.utf8.count <= 8192,
              let address = URLComponents(string: value), address.scheme?.lowercased() == "https",
              let host = address.host, !host.isEmpty, address.user == nil, address.password == nil else { return nil }
        return address.url
    }

    static func onboardingPage(_ url: URL) -> Page? {
        guard url.scheme?.lowercased() == "https",
              [welcomeHost, service.host].contains(url.host?.lowercased()),
              url.port == nil || url.port == 443 else { return nil }
        return Page.allCases.first { url.lastPathComponent.lowercased() == ($0.rawValue + ".html").lowercased() }
    }

    static func sameDocument(_ first: URL, _ second: URL) -> Bool {
        BambooLanternPath.sameOrigin(first, second) && first.path == second.path
    }

    static func business(for reply: Reply, session: URLSession = .shared) async throws -> HavraBEntryConfiguration? {
        guard reply.page == nil, let credential = reply.credential, !credential.isEmpty,
              let details = HavraBChannel(fields: reply.fields.merging(credential) { outer, _ in outer }) else { return nil }
        let token = try await accessToken(from: credential, session: session)
        return HavraBEntryConfiguration(pageURL: reply.url, channel: details.name,
                                        socketURL: details.authorizedURL(token: token))
    }

    private static func accessToken(from credential: [String: Any], session: URLSession) async throws -> String {
        let clock = Date().timeIntervalSince1970 * 1_000
        if let expiry = credential["expires"], (numericValue(expiry) ?? 0) <= clock {
            throw HavraBConnectionError.summerInspirationCanvas
        }
        if let token = BambooLanternPath.text(credential["token"] ?? credential["accessToken"]) { return token }
        guard let key = BambooLanternPath.text(credential["keyName"]),
              key.range(of: #"^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$"#, options: .regularExpression) != nil,
              ["mac", "nonce", "capability", "clientId"].allSatisfy({ BambooLanternPath.text(credential[$0]) != nil }),
              let timestamp = numericValue(credential["timestamp"]), timestamp > 0,
              let ttl = numericValue(credential["ttl"]), ttl > 0, timestamp + ttl > clock else {
            throw HavraBConnectionError.summerInspirationCanvas
        }
        var request = URLRequest(url: tokenService.appendingPathComponent("keys").appendingPathComponent(key)
            .appendingPathComponent("requestToken"), cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: credential)
        let (data, response) = try await session.data(for: request)
        try Task.checkCancellation()
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode),
              let object = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let token = BambooLanternPath.text(object["token"]) else {
            throw HavraBConnectionError.summerInspirationCanvas
        }
        return token
    }

    private static func numericValue(_ value: Any?) -> Double? {
        guard let number = value as? NSNumber, CFGetTypeID(number) != CFBooleanGetTypeID(),
              number.doubleValue.isFinite else { return nil }
        return number.doubleValue
    }
}

extension HavraLifeLaunch.Page: CaseIterable {}

struct HavraBChannel {
    let name: String
    let socket: URL

    init?(fields: [String: Any]) {
        guard let name = BambooLanternPath.text(fields["roomId"]),
              name.utf8.count <= 512,
              let socket = BambooLanternPath.text(fields["webSocketUrl"]),
              let address = URLComponents(string: socket), address.scheme?.lowercased() == "wss",
              address.user == nil, address.password == nil, address.port == nil || address.port == 443,
              let host = address.host?.lowercased(),
              HavraBConfiguration.Network.socketHosts.contains(where: { host == $0 || host.hasSuffix("." + $0) }),
              let url = address.url else { return nil }
        self.name = name
        self.socket = url
    }

    func authorizedURL(token: String) -> URL {
        var address = URLComponents(url: socket, resolvingAgainstBaseURL: false)!
        address.fragment = nil
        let filtered = (address.queryItems ?? []).filter {
            !["key", "accessToken", "format"].contains($0.name)
        }
        address.queryItems = filtered + [
            URLQueryItem(name: "accessToken", value: token),
            URLQueryItem(name: "format", value: "json")
        ]
        return address.url!
    }
}
