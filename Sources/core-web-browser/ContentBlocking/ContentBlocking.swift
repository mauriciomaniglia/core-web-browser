final public class ContentBlocking {
    private let webView: WebViewContract
    private let jsonLoader: (String) -> String?

    public init(webView: WebViewContract, jsonLoader: @escaping (String) -> String? = Helpers.loadJsonContent(filename:)) {
        self.webView = webView
        self.jsonLoader = jsonLoader
    }

    public func setupBasicProtection() {
        let rules = ["CookiesAdvertisingRules", "CookiesAnalyticsRules", "CookiesSocialRules", "CryptominingRules", "FingerprintingRules"]
        registerAndApplyRules(rules)
    }

    public func setupStrictProtection() {
        let rules = ["AdvertisingRules", "AnalyticsRules", "SocialRules", "CryptominingRules", "FingerprintingRules"]
        registerAndApplyRules(rules)
    }

    public func removeProtection() {
        webView.removeAllRules()
    }

    private func registerAndApplyRules(_ rules: [String]) {
        for rule in rules {
            if let content = jsonLoader(rule) {
                webView.registerRule(name: rule, content: content)
                webView.applyRule(name: rule)
            }
        }
    }
}
