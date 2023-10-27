import XCTest
import core_web_browser

class ContentBlockingTests: XCTestCase {

    func test_init_doesNotSendAnyMessages() {
        let (_, webView) = makeSUT()

        XCTAssertEqual(webView.receivedMessages, [])
    }

    func test_setupBasicProtection_applyCorrectRules() {
        let webView = WebViewSpy()
        let sut = ContentBlocking(webView: webView, jsonLoader: { _ in "json content"})

        sut.setupBasicProtection()

        XCTAssertEqual(webView.receivedMessages, [
            .registerRule("CookiesAdvertisingRules", "json content"),
            .applyRule("CookiesAdvertisingRules"),
            .registerRule("CookiesAnalyticsRules", "json content"),
            .applyRule("CookiesAnalyticsRules"),
            .registerRule("CookiesSocialRules", "json content"),
            .applyRule("CookiesSocialRules"),
            .registerRule("CryptominingRules", "json content"),
            .applyRule("CryptominingRules"),
            .registerRule("FingerprintingRules", "json content"),
            .applyRule("FingerprintingRules")
        ])
    }

    func test_setupStrictProtection_applyCorrectRules() {
        let webView = WebViewSpy()
        let sut = ContentBlocking(webView: webView, jsonLoader: { _ in "json content"})

        sut.setupStrictProtection()

        XCTAssertEqual(webView.receivedMessages, [
            .registerRule("AdvertisingRules", "json content"),
            .applyRule("AdvertisingRules"),
            .registerRule("AnalyticsRules", "json content"),
            .applyRule("AnalyticsRules"),
            .registerRule("SocialRules", "json content"),
            .applyRule("SocialRules"),
            .registerRule("CryptominingRules", "json content"),
            .applyRule("CryptominingRules"),
            .registerRule("FingerprintingRules", "json content"),
            .applyRule("FingerprintingRules")
        ])
    }

    func test_removeProtection_removeAllRules() {
        let (sut, webView) = makeSUT()

        sut.removeProtection()

        XCTAssertEqual(webView.receivedMessages, [.removeAllRules])
    }


    // MARK: - Helpers

    private func makeSUT() -> (sut: ContentBlocking, webView: WebViewSpy) {
        let webView = WebViewSpy()
        let sut = ContentBlocking(webView: webView)

        return (sut, webView)
    }
}
