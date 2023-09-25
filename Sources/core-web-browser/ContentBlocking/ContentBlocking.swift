public protocol RulesProviderContract {
    func advertising() -> (name: String, content: String)
    func analytics() -> (name: String, content: String)
    func social() -> (name: String, content: String)
    func cryptomining() -> (name: String, content: String)
    func fingerprinting() -> (name: String, content: String)
    func advertisingCookies() -> (name: String, content: String)
    func analyticsCookies() -> (name: String, content: String)
    func socialCookies() -> (name: String, content: String)
}

final public class ContentBlocking {
    private let webView: WebViewContract
    private let rulesProvider: RulesProviderContract

    public init(webView: WebViewContract, rulesProvider: RulesProviderContract) {
        self.webView = webView
        self.rulesProvider = rulesProvider
    }

    public func setupBasicProtection() {
        let advertisingCookies = rulesProvider.advertisingCookies()
        let analyticsCookies = rulesProvider.analyticsCookies()
        let socialCookies = rulesProvider.socialCookies()
        let cryptomining = rulesProvider.cryptomining()
        let fingerprinting = rulesProvider.fingerprinting()

        webView.registerRule(name: advertisingCookies.name, content: advertisingCookies.content)
        webView.registerRule(name: analyticsCookies.name, content: analyticsCookies.content)
        webView.registerRule(name: socialCookies.name, content: socialCookies.content)
        webView.registerRule(name: cryptomining.name, content: cryptomining.content)
        webView.registerRule(name: fingerprinting.name, content: fingerprinting.content)

        webView.applyRule(name: advertisingCookies.name)
        webView.applyRule(name: analyticsCookies.name)
        webView.applyRule(name: socialCookies.name)
        webView.applyRule(name: cryptomining.name)
        webView.applyRule(name: fingerprinting.name)
    }

    public func setupStrictProtection() {
        let advertising = rulesProvider.advertising()
        let analytics = rulesProvider.analytics()
        let social = rulesProvider.social()
        let cryptomining = rulesProvider.cryptomining()
        let fingerprinting = rulesProvider.fingerprinting()

        webView.registerRule(name: advertising.name, content: advertising.content)
        webView.registerRule(name: analytics.name, content: analytics.content)
        webView.registerRule(name: social.name, content: social.content)
        webView.registerRule(name: cryptomining.name, content: cryptomining.content)
        webView.registerRule(name: fingerprinting.name, content: fingerprinting.content)

        webView.applyRule(name: advertising.name)
        webView.applyRule(name: analytics.name)
        webView.applyRule(name: social.name)
        webView.applyRule(name: cryptomining.name)
        webView.applyRule(name: fingerprinting.name)
    }

    public func removeProtection() {
        webView.removeAllRules()
    }
}
