import XCTest
import WebKit
import core_web_browser

class WebViewProxyTests: XCTestCase {
    let navigation = WKNavigation()

    func test_init_doesNotSendAnyMessage() {
        let (_, _, _, delegate) = makeSUT()

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_init_registerCorrectObserversForWebViewEvents() {
        let (_, webView, _, _) = makeSUT()

        XCTAssertEqual(webView.registeredObservers, ["URL", "canGoBack", "canGoForward", "estimatedProgress"])
    }

    func test_showWebView_makeWebViewVisible() {
        let (sut, webView, _, _) = makeSUT()
        webView.isHidden = true

        sut.showWebView()

        XCTAssertFalse(webView.isHidden)
    }

    func test_sendText_sendsCorrectRequest() {
        let (sut, webView, _, _) = makeSUT()
        webView.isHidden = true

        sut.sendText("https://openai.com")

        XCTAssertEqual(webView.receivedMessages, [.load("https://openai.com")])
    }

    func test_didTapBackButton_requestToGoBackToPreviousPage() {
        let (sut, webView, _, _) = makeSUT()

        sut.didTapBackButton()

        XCTAssertEqual(webView.receivedMessages, [.goBack])
    }

    func test_didTapForwardButton_requestNextPage() {
        let (sut, webView, _, _) = makeSUT()

        sut.didTapForwardButton()

        XCTAssertEqual(webView.receivedMessages, [.goForward])
    }

    func test_canGoBack_deliversCorrectResult() {
        let (sut, webView, _, _) = makeSUT()
        webView.canGoBackMock = true

        _ = sut.canGoBack()

        XCTAssertTrue(webView.canGoBack)
    }

    func test_canGoForward_deliversCorrectResult() {
        let (sut, webView, _, _) = makeSUT()
        webView.canGoForwardMock = true

        _ = sut.canGoForward()

        XCTAssertTrue(webView.canGoForward)
    }

    func test_observeValueForKeyPath_whenKeyPathIsEmptyDontSendAnyMessage() {
        let (sut, _, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_observeValueForKeyPath_whenKeyPathIsNotValidDontSendAnyMessage() {
        let (sut, _, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: "any", of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewURLChange() {
        let (sut, _, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.url), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewCanGoBackChange() {
        let (sut, _, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.canGoBack), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenWebViewCanGoForwardChange() {
        let (sut, _, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.canGoForward), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didLoadPage])
    }

    func test_observeValueForKeyPath_sendsCorrectMessageWhenLoadingProgressUpdates() {
        let (sut, _, _, delegate) = makeSUT()

        sut.observeValue(forKeyPath: #keyPath(WKWebView.estimatedProgress), of: nil, change: nil, context: nil)

        XCTAssertEqual(delegate.receivedMessages, [.didUpdateLoadingProgress(0)])
    }

    func test_registerRules_whenRulesAreEmptyDoNotSendAnyMessage() {
        let (sut, _, ruleStore, _) = makeSUT()

        sut.registerRules([])

        XCTAssertEqual(ruleStore.receivedMessages, [])
    }

    func test_registerRules_whenThereAreRulesCheckIfTheyAreRegistered() {
        let (sut, _, ruleStore, _) = makeSUT()

        sut.registerRules([.advertising, .analytics, .social])

        XCTAssertEqual(ruleStore.receivedMessages, [.lookUpContentRuleList(identifier: "advertising"),
                                                    .lookUpContentRuleList(identifier: "analytics"),
                                                    .lookUpContentRuleList(identifier: "social")])
    }

    func test_registerRules_whenRulesAreAlreadyRegisteredDoNotRegisterAgain() {
        let (sut, _, ruleStore, _) = makeSUT()
        ruleStore.compileContentRuleList(forIdentifier: WebViewRule.advertising.rawValue, encodedContentRuleList: "[]", completionHandler: {_, _ in })
        ruleStore.receivedMessages = []

        sut.registerRules([.advertising])
        ruleStore.simulateLookUpContentRuleListWithRegisteredItem()

        XCTAssertEqual(ruleStore.receivedMessages, [.lookUpContentRuleList(identifier: "advertising")])
    }

    func test_registerRules_whenRuleIsNotRegisteredThenRequestRegistration() {
        let (sut, _, ruleStore, _) = makeSUT()

        sut.registerRules([.advertising])
        ruleStore.simulateLookUpContentRuleListWithUnregisteredItem()

        XCTAssertEqual(ruleStore.receivedMessages, [.lookUpContentRuleList(identifier: "advertising"),
                                                    .compileContentRuleList(identifier: "advertising")])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: WebViewProxy,
        webView: WebViewSpy,
        ruleStore: WKContentRuleListStoreSpy,
        delegate: WebViewProxyProtocolSpy)
    {
        let delegate = WebViewProxyProtocolSpy()
        let webView = WebViewSpy()
        let ruleStore = WKContentRuleListStoreSpy()
        let sut = WebViewProxy(webView: webView, ruleStore: ruleStore)
        sut.delegate = delegate

        return (sut, webView, ruleStore, delegate)
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

    private class WKContentRuleListStoreSpy: WKContentRuleListStore {
        enum Message: Equatable {
            case lookUpContentRuleList(identifier: String)
            case compileContentRuleList(identifier: String)
        }

        var receivedMessages = [Message]()
        var lookUpContentRuleListCompletion: ((WKContentRuleList?, Error?) -> Void)?

        override func lookUpContentRuleList(forIdentifier identifier: String!, completionHandler: ((WKContentRuleList?, Error?) -> Void)!) {
            lookUpContentRuleListCompletion = completionHandler
            receivedMessages.append(.lookUpContentRuleList(identifier: identifier))
        }

        override func compileContentRuleList(forIdentifier identifier: String!, encodedContentRuleList: String!, completionHandler: ((WKContentRuleList?, Error?) -> Void)!) {
            receivedMessages.append(.compileContentRuleList(identifier: identifier))
            super.compileContentRuleList(forIdentifier: identifier, encodedContentRuleList: encodedContentRuleList, completionHandler: completionHandler)
        }

        func simulateLookUpContentRuleListWithRegisteredItem() {
            lookUpContentRuleListCompletion?(WKContentRuleList(), nil)
        }

        func simulateLookUpContentRuleListWithUnregisteredItem() {
            lookUpContentRuleListCompletion?(nil, nil)
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