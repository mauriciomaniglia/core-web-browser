import XCTest
import core_web_browser

protocol RulesProviderContract {}

final class ContentBlocking {
    private let webView: WebViewContract
    private let rulesProvider: RulesProviderContract

    init(webView: WebViewContract, rulesProvider: RulesProviderContract) {
        self.webView = webView
        self.rulesProvider = rulesProvider
    }
}

class ContentBlockingTests: XCTestCase {

    func test_init_doesNotSendAnyMessages() {
        let (_, webView, rulesProvider) = makeSUT()

        XCTAssertEqual(webView.receivedMessages, [])
        XCTAssertEqual(rulesProvider.receivedMessages, [])
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
    enum Message: Equatable {}

    var receivedMessages = [Message]()
}
