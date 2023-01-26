public struct WindowPresentableModel {
    public let showCancelButton: Bool
    public let showReloadButton: Bool
    public let showWebView: Bool
    public let canGoBack: Bool
    public let canGoForward: Bool
    public let progressBar: Int?
}

public class WindowPresenter {
    public var didUpdatePresentableModel: ((WindowPresentableModel) -> Void)?

    public init() {}

    public func didStartNewWindow() {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }

    public func didStartEditing() {
        didUpdatePresentableModel?(.init(showCancelButton: true,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }

    public func didEndEditing() {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }

    public func didLoadPage(canGoBack: Bool, canGoForward: Bool) {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: true,
                                         showWebView: true,
                                         canGoBack: canGoBack,
                                         canGoForward: canGoForward,
                                         progressBar: nil))
    }

    public func didUpdateProgressBar(_ value: Int) {
        didUpdatePresentableModel?(.init(showCancelButton: true,
                                         showReloadButton: false,
                                         showWebView: true,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: value))
    }
}
