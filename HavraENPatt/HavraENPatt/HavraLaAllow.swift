import Foundation
import StoreKit

final class HavraOrchardReceiptWatch {
    static let sharedWatch = HavraOrchardReceiptWatch()

    private var receiptTrailTask: Task<Void, Never>?

    private init() {}

    func beginReceiptWatch() {
        guard receiptTrailTask == nil else { return }

        receiptTrailTask = Task.detached(priority: .background) {
            for await verification in Transaction.updates {
                guard case .verified(let receipt) = verification else {
                    continue
                }

                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .havraOrchardReceiptArrived,
                        object: receipt
                    )
                }
            }
        }
    }
}

extension Notification.Name {
    static let havraOrchardReceiptArrived = Notification.Name(HavraAtlasLexicon.noticeName)
}
