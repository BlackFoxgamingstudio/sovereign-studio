import SwiftUI
import WebKit

struct EmbeddedWebView: NSViewRepresentable {
    let url: URL
    @Binding var reloadTrigger: Bool

    init(url: URL, reloadTrigger: Binding<Bool> = .constant(false)) {
        self.url = url
        self._reloadTrigger = reloadTrigger
    }

    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        config.websiteDataStore = WKWebsiteDataStore.default()
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")
        webView.setValue(false, forKey: "drawsBackground")
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36 SovereignStudio/1.0"
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        if reloadTrigger {
            nsView.reload()
            DispatchQueue.main.async {
                reloadTrigger = false
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: EmbeddedWebView
        init(_ parent: EmbeddedWebView) {
            self.parent = parent
        }

        @MainActor
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor @Sendable () -> Void) {
            let alert = NSAlert()
            alert.messageText = "Sovereign Studio"
            alert.informativeText = message
            alert.alertStyle = .informational
            alert.addButton(withTitle: "OK")
            alert.runModal()
            completionHandler()
        }
    }
}
