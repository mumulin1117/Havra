import Foundation
import StoreKit

final class HavraPurchaseEventMonitor {
    static let shared = HavraPurchaseEventMonitor()

    private var updateTask: Task<Void, Never>?

    private init() {}

    func startListening() {
        guard updateTask == nil else { return }

        updateTask = Task.detached(priority: .background) {
            for await result in Transaction.updates {
                guard case .verified(let transaction) = result else {
                    continue
                }

                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .havraStoreTransactionUpdated,
                        object: transaction
                    )
                }
            }
        }
    }
}

extension Notification.Name {
    static let havraStoreTransactionUpdated = Notification.Name("HavraStoreTransactionUpdated")
}
