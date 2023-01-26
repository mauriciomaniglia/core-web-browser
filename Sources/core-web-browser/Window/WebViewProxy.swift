import WebKit

public protocol WebViewProxyProtocol {
    func didLoadPage()
}

public final class WebViewProxy: NSObject {
    public var delegate: WebViewProxyProtocol?
    internal let webView: WKWebView

    public init(webView: WKWebView) {
        self.webView = webView
        super.init()
        self.webView.navigationDelegate = self
    }

    public func sendText(_ text: String) {
        webView.isHidden = false
        webView.load(URLRequest(url: SearchURLBuilder.makeURL(from: text)))
    }

    public func didTapBackButton() {
        webView.goBack()
    }

    public func didTapForwardButton() {
        webView.goForward()
    }

    public func canGoBack() -> Bool {
        webView.canGoBack
    }

    public func canGoForward() -> Bool {
        webView.canGoForward
    }
}

extension WebViewProxy: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        delegate?.didLoadPage()
    }
}

