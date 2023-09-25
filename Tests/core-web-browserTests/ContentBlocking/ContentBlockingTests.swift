import XCTest
import core_web_browser

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

    func test_removeProtection_removeAllRules() {
        let (sut, webView, _) = makeSUT()

        sut.removeProtection()

        XCTAssertEqual(webView.receivedMessages, [.removeAllRules])
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
