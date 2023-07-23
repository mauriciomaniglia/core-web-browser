import Foundation

public protocol WebViewContract {
    func registerRule(name: String, content: String)
    func applyRules(_ rules: [BlockingRule])
    func showWebView()
    func load(_ url: URL)
    func didTapBackButton()
    func didTapForwardButton()
    func canGoBack() -> Bool
    func canGoForward() -> Bool
}
