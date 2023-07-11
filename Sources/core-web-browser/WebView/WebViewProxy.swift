import WebKit

public enum WebViewRule: String {
    case advertising
    case analytics
    case social
    case cryptomining
    case fingerprinting

    func content() -> String {
        switch self {
        case .advertising:
            return blockAdvertising
        case .analytics:
            return blockAnalytics
        case .social:
            return blockSocial
        case .cryptomining:
            return blockCryptomining
        case .fingerprinting:
            return blockFingerprinting
        }
    }
}

public protocol WebViewProxyProtocol {
    func didLoadPage()
    func didUpdateLoadingProgress(_ progress: Double)
}

public final class WebViewProxy: NSObject {
    public var delegate: WebViewProxyProtocol?
    let webView: WKWebView
    let ruleStore: WKContentRuleListStore

    public init(webView: WKWebView, ruleStore: WKContentRuleListStore) {
        self.webView = webView
        self.ruleStore = ruleStore
        super.init()
        registerObserversForWebView()
    }

    public func registerRules(_ rules: [WebViewRule]) {
        for rule in rules {
            ruleStore.lookUpContentRuleList(forIdentifier: rule.rawValue, completionHandler: {ruleList, _ in
                if ruleList != nil { return }

                self.ruleStore.compileContentRuleList(forIdentifier: rule.rawValue, encodedContentRuleList: rule.content(), completionHandler: {_, _ in })
            })
        }
    }

    public func showWebView() {
        webView.isHidden = false
    }

    public func sendText(_ text: String) {
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
