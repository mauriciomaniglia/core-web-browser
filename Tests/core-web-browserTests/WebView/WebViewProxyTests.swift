import XCTest
import WebKit
import core_web_browser

class WebViewProxyTests: XCTestCase {
    let navigation = WKNavigation()

    func test_init_doesNotSendAnyMessage() {
        let (_, _, delegate) = makeSUT()

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_init_registerCorrectObserversForWebViewEvents() {
        let (_, webView, _) = makeSUT()

        XCTAssertEqual(webView.registeredObservers, ["URL", "canGoBack", "canGoForward", "estimatedProgress"])
    }

    func test_showWebView_makeWebViewVisible() {
        let (sut, webView, _) = makeSUT()
        webView.isHidden = true

        sut.showWebView()

        XCTAssertFalse(webView.isHidden)
    }

    func test_sendText_sendsCorrectRequest() {
        let (sut, webView, _) = makeSUT()
        webView.isHidden = true

        sut.sendText("https://openai.com")

        XCTAssertEqual(webView.receivedMessages, [.load("https://openai.com")])
    }

    func test_didTapBackButton_requestToGoBackToPreviousPage() {
        let (sut, webView, _) = makeSUT()

        sut.didTapBackButton()

        XCTAssertEqual(webView.receivedMessages, [.goBack])
    }

    func test_didTapForwardButton_requestNextPage() {
        let (sut, webView, _) = makeSUT()

        sut.didTapForwardButton()

        XCTAssertEqual(webView.receivedMessages, [.goForward])
    }

    func test_canGoBack_deliversCorrectResult() {
        let (sut, webView, _) = makeSUT()
        webView.canGoBackMock = true

        _ = sut.canGoBack()

        XCTAssertTrue(webView.canGoBack)
    }

    func test_canGoForward_deliversCorrectResult() {
        let (sut, webView, _) = makeSUT()
        webView.canGoForwardMock = true

        _ = sut.canGoForward()

        XCTAssertTrue(webView.canGoForward)
    }

    func test_observeValueForKeyPath_whenKeyPathIsEmptyDontSendAnyMessage() {
        let (sut, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_observeValueForKeyPath_whenKeyPathIsNotValidDontSendAnyMessage() {
        let (sut, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: "any", of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewURLChange() {
        let (sut, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.url), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewCanGoBackChange() {
        let (sut, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.canGoBack), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewCanGoForwardChange() {
        let (sut, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.canGoForward), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenLoadingProgressUpdates() {
        let (sut, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.estimatedProgress), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didUpdateLoadingProgress(0)])
    }
    

    // MARK: - Helpers

    private func makeSUT() -> (sut: WebViewProxy, webView: WebViewSpy, delegate: WebViewProxyProtocolSpy) {
        let delegate = WebViewProxyProtocolSpy()
        let webView = WebViewSpy()
        let sut = WebViewProxy(webView: webView)
        sut.delegate = delegate

        return (sut, webView, delegate)
    }

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
