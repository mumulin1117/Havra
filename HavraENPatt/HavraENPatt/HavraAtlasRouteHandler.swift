import Foundation
import WebKit

final class HavraAtlasRouteHandler: NSObject, WKURLSchemeHandler {
    private let atlasRootURL: URL?

    init(atlasRootURL: URL? = Bundle.main.url(forResource: "HavraWebRuntime", withExtension: "bundle")) {
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
        if inboundPath.isEmpty || inboundPath == "/" {
            inboundPath = "/index.html"
        }

        inboundPath = HavraAtlasPathGuide.foldedAtlasPath(inboundPath)
        guard !inboundPath.isEmpty,
              !inboundPath.hasPrefix("~") else {
            return nil
        }

        return atlasRoot.appendingPathComponent(HavraAtlasPathGuide.atlasPath(for: inboundPath))
    }

    private static func contentType(for pathExtension: String) -> String {
        switch pathExtension.lowercased() {
        case "html":
            return "text/html"
        case "js", "mjs":
            return "application/javascript"
        case "css":
            return "text/css"
        case "json":
            return "application/json"
        case "png":
            return "image/png"
        case "jpg", "jpeg":
            return "image/jpeg"
        case "gif":
            return "image/gif"
        case "svg":
            return "image/svg+xml"
        case "webp":
            return "image/webp"
        case "mp4":
            return "video/mp4"
        case "woff":
            return "font/woff"
        case "woff2":
            return "font/woff2"
        case "ttf":
            return "font/ttf"
        default:
            return "application/octet-stream"
        }
    }

    private static func scriptEncoding(for pathExtension: String) -> String? {
        switch pathExtension.lowercased() {
        case "html", "js", "mjs", "css", "json", "svg":
            return "utf-8"
        default:
            return nil
        }
    }
}

private enum HavraAtlasRouteError: Error {
    case resourceUnavailable
}
