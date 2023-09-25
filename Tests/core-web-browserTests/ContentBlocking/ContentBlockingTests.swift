import XCTest
import core_web_browser

protocol RulesProviderContract {
    func advertising() -> (name: String, content: String)
    func analytics() -> (name: String, content: String)
    func social() -> (name: String, content: String)
    func cryptomining() -> (name: String, content: String)
    func fingerprinting() -> (name: String, content: String)
    func advertisingCookies() -> (name: String, content: String)
    func analyticsCookies() -> (name: String, content: String)
    func socialCookies() -> (name: String, content: String)
}

final class ContentBlocking {
    private let webView: WebViewContract
    private let rulesProvider: RulesProviderContract

    init(webView: WebViewContract, rulesProvider: RulesProviderContract) {
        self.webView = webView
        self.rulesProvider = rulesProvider
    }

    func setupBasicProtection() {
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

    func setupStrictProtection() {
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
}

class ContentBlockingTests: XCTestCase {

    func test_init_doesNotSendAnyMessages() {
        let (_, webView, rulesProvider) = makeSUT()

        XCTAssertEqual(webView.receivedMessages, [])
        XCTAssertEqual(rulesProvider.receivedMessages, [])
    }

    func test_setupBasicProtection_applyCorrectRules() {
        let (sut, webView, rulesProvider) = makeSUT()

        sut.setupBasicProtection()

        XCTAssertEqual(rulesProvider.receivedMessages, [
            .advertisingCookies,
            .analyticsCookies,
            .socialCookies,
            .cryptomining,
            .fingerprinting
        ])
        XCTAssertEqual(webView.receivedMessages, [
            .registerRule("advertisingCookies", "advertisingCookies content"),
            .registerRule("analyticsCookies", "analyticsCookies content"),
            .registerRule("socialCookies", "socialCookies content"),
            .registerRule("cryptomining", "cryptomining content"),
            .registerRule("fingerprinting", "fingerprinting content"),

            .applyRule("advertisingCookies"),
            .applyRule("analyticsCookies"),
            .applyRule("socialCookies"),
            .applyRule("cryptomining"),
            .applyRule("fingerprinting")
        ])
    }

    func test_setupStrictProtection_applyCorrectRules() {
        let (sut, webView, rulesProvider) = makeSUT()

        sut.setupStrictProtection()

        XCTAssertEqual(rulesProvider.receivedMessages, [
            .advertising,
            .analytics,
            .social,
            .cryptomining,
            .fingerprinting
        ])
        XCTAssertEqual(webView.receivedMessages, [
            .registerRule("advertising", "advertising content"),
            .registerRule("analytics", "analytics content"),
            .registerRule("social", "social content"),
            .registerRule("cryptomining", "cryptomining content"),
            .registerRule("fingerprinting", "fingerprinting content"),

            .applyRule("advertising"),
            .applyRule("analytics"),
            .applyRule("social"),
            .applyRule("cryptomining"),
            .applyRule("fingerprinting")
        ])
    }


    // MARK: - Helpers

    private func makeSUT() -> (sut: ContentBlocking, webView: WebViewSpy, rulesProvider: RulesProviderSpy) {
        let webView = WebViewSpy()
        let rulesProvider = RulesProviderSpy()
        let sut = ContentBlocking(webView: webView, rulesProvider: rulesProvider)

        return (sut, webView, rulesProvider)
    }
}

private class RulesProviderSpy: RulesProviderContract {
    enum Message: Equatable {
        case advertising
        case analytics
        case social
        case cryptomining
        case fingerprinting
        case advertisingCookies
        case analyticsCookies
        case socialCookies
    }

    var receivedMessages = [Message]()

    func advertising() -> (name: String, content: String) {
        receivedMessages.append(.advertising)

        return ("advertising", "advertising content")
    }
    
    func analytics() -> (name: String, content: String) {
        receivedMessages.append(.analytics)

        return ("analytics", "analytics content")
    }
    
    func social() -> (name: String, content: String) {
        receivedMessages.append(.social)

        return ("social", "social content")
    }
    
    func cryptomining() -> (name: String, content: String) {
        receivedMessages.append(.cryptomining)

        return ("cryptomining", "cryptomining content")
    }
    
    func fingerprinting() -> (name: String, content: String) {
        receivedMessages.append(.fingerprinting)

        return ("fingerprinting", "fingerprinting content")
    }
    
    func advertisingCookies() -> (name: String, content: String) {
        receivedMessages.append(.advertisingCookies)

        return ("advertisingCookies", "advertisingCookies content")
    }
    
    func analyticsCookies() -> (name: String, content: String) {
        receivedMessages.append(.analyticsCookies)

        return ("analyticsCookies", "analyticsCookies content")
    }
    
    func socialCookies() -> (name: String, content: String) {
        receivedMessages.append(.socialCookies)

        return ("socialCookies", "socialCookies content")
    }
}
