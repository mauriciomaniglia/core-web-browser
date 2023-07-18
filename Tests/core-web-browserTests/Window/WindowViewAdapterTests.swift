import XCTest
@testable import core_web_browser

class WindowViewAdapterTests: XCTestCase {

    func test_didRequestSearch_sendsCorrectMessages() {
        let (sut, webView, presenter) = makeSUT()

        sut.didRequestSearch("www.apple.com")

        XCTAssertEqual(webView.receivedMessages, [.showWebView, .load(url: URL(string: "http://www.apple.com")!)])
        XCTAssertEqual(presenter.receivedMessages, [])
    }

    func test_didStartTyping_sendsCorrectMessages() {
        let (sut, webView, presenter) = makeSUT()

        sut.didStartTyping()

        XCTAssertEqual(presenter.receivedMessages, [.didStartEditing])
        XCTAssertEqual(webView.receivedMessages, [])
    }

    func test_didEndTyping_sendsCorrectMessages() {
        let (sut, webView, presenter) = makeSUT()

        sut.didEndTyping()

        XCTAssertEqual(presenter.receivedMessages, [.didEndEditing])
        XCTAssertEqual(webView.receivedMessages, [])
    }

    func test_didTapBackButton_sendsCorrectMessages() {
        let (sut, webView, presenter) = makeSUT()

        sut.didTapBackButton()

        XCTAssertEqual(presenter.receivedMessages, [])
        XCTAssertEqual(webView.receivedMessages, [.didTapBackButton])
    }

    func test_didTapForwardButton_sendsCorrectMessages() {
        let (sut, webView, presenter) = makeSUT()

        sut.didTapForwardButton()

        XCTAssertEqual(presenter.receivedMessages, [])
        XCTAssertEqual(webView.receivedMessages, [.didTapForwardButton])
    }

    func test_didLoadPage_sendsCorrectMessages() {
        let (sut, webView, presenter) = makeSUT()

        sut.didLoadPage()

        XCTAssertEqual(webView.receivedMessages, [.canGoBack, .canGoForward])
        XCTAssertEqual(presenter.receivedMessages, [.didLoadPage(canGoBack: true, canGoForward: true)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: WindowViewAdapter, webView: WebViewSpy, presenter: WindowPresenterSpy) {
        let webView = WebViewSpy()
        let presenter = WindowPresenterSpy()
        let sut = WindowViewAdapter(webView: webView, presenter: presenter)

        return (sut, webView, presenter)
    }
}

private class WebViewSpy: WebViewContract {
    enum Message: Equatable {
        case showWebView
        case load(url: URL)
        case didTapBackButton
        case didTapForwardButton
        case canGoBack
        case canGoForward
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
        receivedMessages.append(.didTapBackButton)
    }

    func didTapForwardButton() {
        receivedMessages.append(.didTapForwardButton)
    }

    func canGoBack() -> Bool {
        receivedMessages.append(.canGoBack)
        return true
    }

    func canGoForward() -> Bool {
        receivedMessages.append(.canGoForward)
        return true
    }
}

private class WindowPresenterSpy: WindowPresenter {
    enum Message: Equatable {
        case didStartEditing
        case didEndEditing
        case didLoadPage(canGoBack: Bool, canGoForward: Bool)
    }

    var receivedMessages = [Message]()

    override func didStartEditing() {
        receivedMessages.append(.didStartEditing)
    }

    override func didEndEditing() {
        receivedMessages.append(.didEndEditing)
    }

    override func didLoadPage(canGoBack: Bool, canGoForward: Bool) {
        receivedMessages.append(.didLoadPage(canGoBack: canGoBack, canGoForward: canGoForward))
    }
}
