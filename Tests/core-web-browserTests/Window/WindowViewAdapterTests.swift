import XCTest
import core_web_browser

class WindowViewAdapterTests: XCTestCase {

    func test_didRequestSearch_sendsCorrectMessages() {
        let webView = WebViewSpy()
        let presenter = WindowPresenter()
        let sut = WindowViewAdapter(webView: webView, presenter: presenter)

        sut.didRequestSearch("www.apple.com")

        XCTAssertEqual(webView.receivedMessages, [.showWebView, .load(url: URL(string: "http://www.apple.com")!)])
    }
}

private class WebViewSpy: WebViewContract {
    enum Message: Equatable {
        case showWebView
        case load(url: URL)
    }

    var receivedMessages = [Message]()

    func registerRules(_ rules: [WebViewRule]) {

    }

    func applyRules(_ rules: [WebViewRule]) {

    }

    func showWebView() {
        receivedMessages.append(.showWebView)
    }

    func load(_ url: URL) {
        receivedMessages.append(.load(url: url))
    }

    func didTapBackButton() {

    }

    func didTapForwardButton() {

    }

    func canGoBack() -> Bool {
        return true
    }

    func canGoForward() -> Bool {
        return true
    }
}
