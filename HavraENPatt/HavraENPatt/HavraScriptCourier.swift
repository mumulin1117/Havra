import WebKit

final class HavraScriptCourier: NSObject, WKScriptMessageHandler {
    weak var receiver: WKScriptMessageHandler?

    init(receiver: WKScriptMessageHandler) {
        self.receiver = receiver
        super.init()
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive scriptPacket: WKScriptMessage
    ) {
        receiver?.userContentController(userContentController, didReceive: scriptPacket)
    }
}
