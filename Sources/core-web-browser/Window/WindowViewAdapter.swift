final class WindowViewAdapter: WindowViewContract {
    private let webViewProxy: WebViewProxy
    private let presenter: WindowPresenter

    init(webViewProxy: WebViewProxy, presenter: WindowPresenter) {
        self.webViewProxy = webViewProxy
        self.presenter = presenter
    }

    func didRequestSearch(_ text: String) {
        webViewProxy.sendText(text)
    }

    func didStartTyping() {
        presenter.didStartEditing()
    }

    func didEndTyping() {
        presenter.didEndEditing()
    }

    func didTapBackButton() {
        webViewProxy.didTapBackButton()
    }

    func didTapForwardButton() {
        webViewProxy.didTapForwardButton()
    }
}

extension WindowViewAdapter: WebViewProxyProtocol {
    func didLoadPage() {
        presenter.didLoadPage(canGoBack: webViewProxy.canGoBack(), canGoForward: webViewProxy.canGoForward())
    }
}
