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
        registerObserversForWebView()
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

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }

        switch keyPath {
        case #keyPath(WKWebView.url),
            #keyPath(WKWebView.canGoBack),
            #keyPath(WKWebView.canGoForward):
            delegate?.didLoadPage()
        default:
            break
        }
    }

    // MARK: Private methods

    private func registerObserversForWebView() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), context: nil)
    }
}

