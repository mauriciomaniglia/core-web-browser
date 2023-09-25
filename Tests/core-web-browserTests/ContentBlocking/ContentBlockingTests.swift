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
