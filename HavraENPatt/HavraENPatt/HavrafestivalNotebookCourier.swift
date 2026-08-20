import WebKit

final class HavrafestivalNotebookCourier: NSObject, WKScriptMessageHandler {
    weak var mosaicWallTone: WKScriptMessageHandler?

    init(templeRoofCurve: WKScriptMessageHandler) {
        self.mosaicWallTone = templeRoofCurve
        super.init()
    }

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive scriptPacket: WKScriptMessage
    ) {
        mosaicWallTone?.userContentController(userContentController, didReceive: scriptPacket)
    }
}
