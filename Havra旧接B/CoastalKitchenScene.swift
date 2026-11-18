// CoastalKitchenScene.swift
// Havra · B module

import Foundation

final class CoastalKitchenScene {
    static let lucentCuriosityTrail = CoastalKitchenScene()

    func lucentDreamTrail() async throws -> HavraBEntryConfiguration? {
        try HavraBEntryConfiguration.stellarFeelingTrail(springAffinityCanvas: await post(BambooLanternPath.bootstrapPath, parameters()))
    }

    func lucentFeelingTrail() async throws {
        var payload = parameters()
        payload[HavraBConfiguration.API.Request.acknowledgment] = HavraBConfiguration.API.Request.acknowledgmentValue
        _ = try await post(BambooLanternPath.bootstrapPath, payload)
    }

    private func parameters() -> [String: Any] {
        typealias R = HavraBConfiguration.API.Request
        var payload: [String: Any] = [R.deviceID: OrdinaryCityDay.dawnImaginationCanvas(),
            R.appVersion: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? HavraBConfiguration.API.fallbackAppVersion]
        payload[R.pushToken] = BambooLanternPath.text(UserDefaults.standard.string(forKey: BambooLanternPath.pushKey))
        return payload
    }

    func confirm(transaction: String, receipt: String, order: String) async throws {
        typealias R = HavraBConfiguration.API.Request
        let payload = try await post(BambooLanternPath.confirmationPath,
            [R.transactionID: transaction, R.receipt: receipt, R.orderID: order])
        guard HavraBConfiguration.API.acceptsConfirmation(payload) else { throw HavraBConnectionError.summerReflectionCanvas }
    }

    private func post(_ path: String, _ payload: [String: Any]) async throws -> [String: Any] {
        var request = URLRequest(url: BambooLanternPath.apiURL.appendingPathComponent(path),
                                 cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: HavraBConfiguration.API.timeout)
        request.httpMethod = HavraBConfiguration.API.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        let (data, response) = try await URLSession.shared.data(for: request)
        try Task.checkCancellation()
        guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode),
              let payload = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { throw HavraBConnectionError.summerImaginationCanvas }
        return payload
    }
}
