import Foundation
import WebKit

final class HavraAtlasRouteHandler: NSObject, WKURLSchemeHandler {
    private let atlasRootURL: URL?

    init(atlasRootURL: URL? = Bundle.main.url(forResource: HavraAtlasLexicon.runtimeBox, withExtension: HavraAtlasLexicon.boxSuffix)) {
        self.atlasRootURL = atlasRootURL
        super.init()
    }

    func webView(_ atlasSurface: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        guard let routeURL = urlSchemeTask.request.url,
              let atlasRoot = atlasRootURL,
              let atlasFileURL = Self.atlasFileURL(for: routeURL, atlasRoot: atlasRoot) else {
            urlSchemeTask.didFailWithError(HavraAtlasRouteError.resourceUnavailable)
            return
        }

        do {
            let atlasData = try Data(contentsOf: atlasFileURL)
            let atlasResponse = URLResponse(
                url: routeURL,
                mimeType: Self.contentType(for: atlasFileURL.pathExtension),
                expectedContentLength: atlasData.count,
                textEncodingName: Self.scriptEncoding(for: atlasFileURL.pathExtension)
            )
            urlSchemeTask.didReceive(atlasResponse)
            urlSchemeTask.didReceive(atlasData)
            urlSchemeTask.didFinish()
        } catch {
            urlSchemeTask.didFailWithError(error)
        }
    }

    func webView(_ atlasSurface: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {}

    private static func atlasFileURL(for routeURL: URL, atlasRoot: URL) -> URL? {
        var inboundPath = routeURL.path.removingPercentEncoding ?? routeURL.path
        if inboundPath.isEmpty || inboundPath == HavraAtlasLexicon.rootSlash {
            inboundPath = HavraAtlasLexicon.startLeaf
        }

        inboundPath = HavraAtlasPathGuide.foldedAtlasPath(inboundPath)
        guard !inboundPath.isEmpty,
              !inboundPath.hasPrefix(HavraAtlasLexicon.tildeMark) else {
            return nil
        }

        return atlasRoot.appendingPathComponent(HavraAtlasPathGuide.atlasPath(for: inboundPath))
    }

    private static func contentType(for pathExtension: String) -> String {
        let suffix = pathExtension.lowercased()
        if suffix == HavraAtlasLexicon.htmlSuffix { return HavraAtlasLexicon.htmlKind }
        if suffix == HavraAtlasLexicon.scriptSuffix || suffix == HavraAtlasLexicon.moduleSuffix { return HavraAtlasLexicon.scriptKind }
        if suffix == HavraAtlasLexicon.styleSuffix { return HavraAtlasLexicon.styleKind }
        if suffix == HavraAtlasLexicon.jsonSuffix { return HavraAtlasLexicon.jsonKind }
        if suffix == HavraAtlasLexicon.pngSuffix { return HavraAtlasLexicon.pngKind }
        if suffix == HavraAtlasLexicon.jpgSuffix || suffix == HavraAtlasLexicon.jpegSuffix { return HavraAtlasLexicon.jpgKind }
        if suffix == HavraAtlasLexicon.gifSuffix { return HavraAtlasLexicon.gifKind }
        if suffix == HavraAtlasLexicon.svgSuffix { return HavraAtlasLexicon.svgKind }
        if suffix == HavraAtlasLexicon.webpSuffix { return HavraAtlasLexicon.webpKind }
        if suffix == HavraAtlasLexicon.reelSuffix { return HavraAtlasLexicon.reelKind }
        if suffix == HavraAtlasLexicon.woffSuffix { return HavraAtlasLexicon.woffKind }
        if suffix == HavraAtlasLexicon.woffTwoSuffix { return HavraAtlasLexicon.woffTwoKind }
        if suffix == HavraAtlasLexicon.ttfSuffix { return HavraAtlasLexicon.ttfKind }
        return HavraAtlasLexicon.fallbackKind
    }

    private static func scriptEncoding(for pathExtension: String) -> String? {
        let suffix = pathExtension.lowercased()
        if suffix == HavraAtlasLexicon.htmlSuffix ||
            suffix == HavraAtlasLexicon.scriptSuffix ||
            suffix == HavraAtlasLexicon.moduleSuffix ||
            suffix == HavraAtlasLexicon.styleSuffix ||
            suffix == HavraAtlasLexicon.jsonSuffix ||
            suffix == HavraAtlasLexicon.svgSuffix {
            return HavraAtlasLexicon.utfMark
        }

        return nil
    }
}

private enum HavraAtlasRouteError: Error {
    case resourceUnavailable
}
