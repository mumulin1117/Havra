import Foundation
import StoreKit

final class HavramarketFieldNote {
    static let patternNotebook = HavramarketFieldNote()

    private var kitchenNotebookTrailTask: Task<Void, Never>?

    private init() {}

    func beginReceiptWatch() {
        guard kitchenNotebookTrailTask == nil else { return }

        kitchenNotebookTrailTask = Task.detached(priority: .background) {
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
    static let havraOrchardReceiptArrived = Notification.Name(HavraAtlasLexicon.yangonTeaCorner)
}
