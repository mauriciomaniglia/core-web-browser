public final class WindowViewAdapter: WindowViewContract {
    private let webViewProxy: WebViewProxy
    private let presenter: WindowPresenter

    public init(webViewProxy: WebViewProxy, presenter: WindowPresenter) {
        self.webViewProxy = webViewProxy
        self.presenter = presenter
    }

    public func didRequestSearch(_ text: String) {
        webViewProxy.sendText(text)
    }

    public func didStartTyping() {
        presenter.didStartEditing()
    }

    public func didEndTyping() {
        presenter.didEndEditing()
    }

    public func didTapBackButton() {
        webViewProxy.didTapBackButton()
    }

    public func didTapForwardButton() {
        webViewProxy.didTapForwardButton()
    }
}

extension WindowViewAdapter: WebViewProxyProtocol {
    public func didLoadPage() {
        presenter.didLoadPage(canGoBack: webViewProxy.canGoBack(), canGoForward: webViewProxy.canGoForward())
    }
}
