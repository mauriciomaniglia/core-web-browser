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

    func test_setupBasicProtection_whenWhitelistAreAvailableApplyCorrectRules() {
        let webView = WebViewSpy()
        let sut = ContentBlocking(webView: webView, jsonLoader: { _ in "json content"})

        sut.setupBasicProtection(whitelist: ["www.apple.com", "www.google.com"])

        XCTAssertEqual(webView.receivedMessages, [
            .registerRule("CookiesAdvertisingRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("CookiesAdvertisingRules"),
            .registerRule("CookiesAnalyticsRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("CookiesAnalyticsRules"),
            .registerRule("CookiesSocialRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("CookiesSocialRules"),
            .registerRule("CryptominingRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("CryptominingRules"),
            .registerRule("FingerprintingRules", "json content", ["www.apple.com", "www.google.com"]),
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

    func test_setupStrictProtection_whenWhitelistAreAvailableApplyCorrectRules() {
        let webView = WebViewSpy()
        let sut = ContentBlocking(webView: webView, jsonLoader: { _ in "json content"})

        sut.setupStrictProtection(whitelist: ["www.apple.com", "www.google.com"])

        XCTAssertEqual(webView.receivedMessages, [
            .registerRule("AdvertisingRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("AdvertisingRules"),
            .registerRule("AnalyticsRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("AnalyticsRules"),
            .registerRule("SocialRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("SocialRules"),
            .registerRule("CryptominingRules", "json content", ["www.apple.com", "www.google.com"]),
            .applyRule("CryptominingRules"),
            .registerRule("FingerprintingRules", "json content", ["www.apple.com", "www.google.com"]),
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
