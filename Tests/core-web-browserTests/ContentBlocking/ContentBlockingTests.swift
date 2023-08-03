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
        let webView = WebViewSpy()
        _ = ContentBlocking(webView: webView)

        XCTAssertEqual(webView.receivedMessages, [])
    }
}
