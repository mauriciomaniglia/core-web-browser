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

    func test_init_registerCorrectObserversForWebViewEvents() {
        let webView = WebViewSpy()
        _ = WebViewProxy(webView: webView)

        XCTAssertEqual(webView.registeredObservers, ["URL", "canGoBack", "canGoForward", "estimatedProgress"])
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

    func test_observeValueForKeyPath_whenKeyPathIsEmptyDontSendAnyMessage() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        sut.observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_observeValueForKeyPath_whenKeyPathIsNotValidDontSendAnyMessage() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        sut.observeValue(forKeyPath: "any", of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewURLChange() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        sut.observeValue(forKeyPath: #keyPath(WKWebView.url), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewCanGoBackChange() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        sut.observeValue(forKeyPath: #keyPath(WKWebView.canGoBack), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewCanGoForwardChange() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        sut.observeValue(forKeyPath: #keyPath(WKWebView.canGoForward), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenLoadingProgressUpdates() {
        let delegate = WebViewProxyProtocolSpy()
        let sut = WebViewProxy(webView: WebViewSpy())
        sut.delegate = delegate

        sut.observeValue(forKeyPath: #keyPath(WKWebView.estimatedProgress), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didUpdateLoadingProgress(0)])
    }
    

    // MARK: - Helpers

    private class WebViewSpy: WKWebView {
        enum Message: Equatable {
            case load(_ requestDescription: String)
            case goBack
            case goForward
        }

        var receivedMessages = [Message]()
        var registeredObservers = [String]()
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

        override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
            registeredObservers.append(keyPath)
        }
    }

    private class WebViewProxyProtocolSpy: WebViewProxyProtocol {
        enum Message: Equatable {
            case didLoadPage
            case didUpdateLoadingProgress(_: Double)
        }

        var receivedMessages = [Message]()

        func didLoadPage() {
            receivedMessages.append(.didLoadPage)
        }

        func didUpdateLoadingProgress(_ progress: Double) {
            receivedMessages.append(.didUpdateLoadingProgress(progress))
        }
    }
}
