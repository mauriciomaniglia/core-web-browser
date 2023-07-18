import Foundation
import core_web_browser

class WebViewSpy: WebViewContract {
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
