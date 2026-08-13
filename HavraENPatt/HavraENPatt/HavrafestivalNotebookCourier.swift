import WebKit

final class HavrafestivalNotebookCourier: NSObject, WKScriptMessageHandler {
    weak var kitchenNotebook: WKScriptMessageHandler?

    init(receiver: WKScriptMessageHandler) {
        self.kitchenNotebook = receiver
        super.init()
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive scriptPacket: WKScriptMessage
    ) {
        kitchenNotebook?.userContentController(userContentController, didReceive: scriptPacket)
    }
}
