import Foundation

public protocol WebViewContract {
    func registerRules(_ rules: [WebViewRule])
    func applyRules(_ rules: [WebViewRule])
    func showWebView()
    func load(_ url: URL)
    func didTapBackButton()
    func didTapForwardButton()
    func canGoBack() -> Bool
    func canGoForward() -> Bool
}
