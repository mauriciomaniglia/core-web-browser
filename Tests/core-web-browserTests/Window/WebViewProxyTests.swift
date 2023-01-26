import XCTest
import WebKit
import core_web_browser

class WebViewProxyTests: XCTestCase {
    let navigation = WKNavigation()

    func test_init_doesNotSendAnyMessage() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_sendText_makeWebViewVisible() {
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)
        webView.isHidden = true

        sut.sendText("some text")

        XCTAssertFalse(webView.isHidden)
    }

    func test_sendText_sendsCorrectRequest() {
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)
        webView.isHidden = true

        sut.sendText("https://openai.com")

        XCTAssertEqual(webView.receivedMessages, [.load("https://openai.com")])
    }

    func test_didTapBackButton_requestToGoBackToPreviousPage() {
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)

        sut.didTapBackButton()

        XCTAssertEqual(webView.receivedMessages, [.goBack])
    }

    func test_didTapForwardButton_requestNextPage() {
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)

        sut.didTapForwardButton()

        XCTAssertEqual(webView.receivedMessages, [.goForward])
    }

    func test_canGoBack_deliversCorrectResult() {
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)
        webView.canGoBackMock = true

        _ = sut.canGoBack()

        XCTAssertTrue(webView.canGoBack)
    }

    func test_canGoForward_deliversCorrectResult() {
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)
        webView.canGoForwardMock = true

        _ = sut.canGoForward()

        XCTAssertTrue(webView.canGoForward)
    }

    func test_webViewDidCommit_sendsDelegatePageDidLoad() {
        let delegate = WebViewProxyProtocolSpy()
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)
        sut.delegate = delegate

        sut.webView(webView, didCommit: navigation)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    // MARK: - Helpers

    private class WebViewSpy: WKWebView {
        enum Message: Equatable {
            case load(_ requestDescription: String)
            case goBack
            case goForward
        }

        var receivedMessages = [Message]()
        var canGoBackMock = false
        var canGoForwardMock = false

        override func load(_ request: URLRequest) -> WKNavigation? {
            receivedMessages.append(.load(request.description))
            return super.load(request)
        }

        override func goBack() -> WKNavigation? {
            receivedMessages.append(.goBack)
            return super.goBack()
        }

        override func goForward() -> WKNavigation? {
            receivedMessages.append(.goForward)
            return super.goForward()
        }

        override var canGoBack: Bool {
            return canGoBackMock
        }

        override var canGoForward: Bool {
            return canGoForwardMock
        }
    }

    private class WebViewProxyProtocolSpy: WebViewProxyProtocol {
        enum Message {
            case didLoadPage
        }

        var receivedMessages = [Message]()

        func didLoadPage() {
            receivedMessages.append(.didLoadPage)
        }
    }
}
