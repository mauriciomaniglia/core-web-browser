import WebKit

public protocol WebViewProxyDelegate {
    func didLoadPage()
    func didUpdateLoadingProgress(_ progress: Double)
}

public final class WebViewProxy: NSObject, WebViewContract {
    public var delegate: WebViewProxyDelegate?
    public let webView: WKWebView
    let ruleStore: WKContentRuleListStore

    public init(webView: WKWebView = WKWebView(), ruleStore: WKContentRuleListStore = WKContentRuleListStore.default()) {
        self.webView = webView
        self.ruleStore = ruleStore
        super.init()
        registerObserversForWebView()
    }

    public func registerRule(name: String, content: String, whitelist: [String] = []) {
        ruleStore.lookUpContentRuleList(forIdentifier: name, completionHandler: { ruleList, _ in
            if ruleList != nil { return }

            self.ruleStore.compileContentRuleList(forIdentifier: name, encodedContentRuleList: content, completionHandler: {_, _ in })
        })
    }

    public func applyRule(name: String) {
        ruleStore.lookUpContentRuleList(forIdentifier: name, completionHandler: { ruleList, _ in
            guard let ruleList = ruleList else { return }

            self.webView.configuration.userContentController.add(ruleList)
        })
    }

    public func removeAllRules() {
        self.webView.configuration.userContentController.removeAllContentRuleLists()
    }

    public func showWebView() {
        webView.isHidden = false
    }

    public func load(_ url: URL) {
        webView.load(URLRequest(url: url))
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
        case #keyPath(WKWebView.url), #keyPath(WKWebView.canGoBack), #keyPath(WKWebView.canGoForward):
            delegate?.didLoadPage()
        case #keyPath(WKWebView.estimatedProgress):
            delegate?.didUpdateLoadingProgress(webView.estimatedProgress)
        default:
            break
        }
    }

    // MARK: Private methods

    private func registerObserversForWebView() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
}

