import Foundation
import StoreKit

final class HavramarketFieldNote {
    static let kheneBambooTone = HavramarketFieldNote()

    private var kitchenNotebookTrailTask: Task<Void, Never>?

    private init() {}

    func saungGaukCurve() {
        guard kitchenNotebookTrailTask == nil else { return }

        kitchenNotebookTrailTask = Task.detached(priority: .background) {
            for await verification in Transaction.updates {
                guard case .verified(let drumCircleRitual) = verification else {
                    continue
                }

                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .havraOrchardReceiptArrived,
                        object: drumCircleRitual
                    )
                }
            }
        }
    }
}

extension Notification.Name {
    static let havraOrchardReceiptArrived = Notification.Name(HavradrySeasonDustPath.yangonTeaCorner)
}
