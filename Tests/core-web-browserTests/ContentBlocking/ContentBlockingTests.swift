import XCTest
import core_web_browser

final class ContentBlocking {
    private let webView: WebViewContract

    init(webView: WebViewContract) {
        self.webView = webView
    }
}

class ContentBlockingTests: XCTestCase {

    func test_init_doesNotSendAnyMessages() {
        let (_, webView) = makeSUT()

        XCTAssertEqual(webView.receivedMessages, [])
    }


    // MARK: - Helpers

    private func makeSUT() -> (sut: ContentBlocking, webView: WebViewSpy) {
        let webView = WebViewSpy()
        let sut = ContentBlocking(webView: webView)

        return (sut, webView)
    }
}
