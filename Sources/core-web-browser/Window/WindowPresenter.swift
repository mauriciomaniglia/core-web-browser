public class WindowPresenter {
    public var didUpdatePresentableModel: ((WindowPresentableModel) -> Void)?
    private var currentPresentableModel: WindowPresentableModel

    public init() {
        currentPresentableModel = WindowPresentableModel(showCancelButton: false,
                                                         showReloadButton: false,
                                                         showWebView: false,
                                                         canGoBack: false,
                                                         canGoForward: false,
                                                         progressBar: nil)
    }

    public func didStartNewWindow() {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }

    public func didStartEditing() {
        let newPresentableModel = WindowPresentableModel(showCancelButton: true,
                                                         showReloadButton: false,
                                                         showWebView: currentPresentableModel.showWebView,
                                                         canGoBack: currentPresentableModel.canGoBack,
                                                         canGoForward: currentPresentableModel.canGoForward,
                                                         progressBar: nil)
        currentPresentableModel = newPresentableModel

        didUpdatePresentableModel?(newPresentableModel)
    }

    public func didEndEditing() {
        let newPresentableModel = WindowPresentableModel(showCancelButton: false,
                                                         showReloadButton: currentPresentableModel.showReloadButton,
                                                         showWebView: currentPresentableModel.showWebView,
                                                         canGoBack: currentPresentableModel.canGoBack,
                                                         canGoForward: currentPresentableModel.canGoForward,
                                                         progressBar: nil)
        currentPresentableModel = newPresentableModel

        didUpdatePresentableModel?(newPresentableModel)
    }

    public func didLoadPage(canGoBack: Bool, canGoForward: Bool) {
        let newPresentableModel = WindowPresentableModel(showCancelButton: false,
                                                         showReloadButton: true,
                                                         showWebView: true,
                                                         canGoBack: canGoBack,
                                                         canGoForward: canGoForward,
                                                         progressBar: nil)
        currentPresentableModel = newPresentableModel

        didUpdatePresentableModel?(newPresentableModel)
    }

    public func didUpdateProgressBar(_ value: Double) {
        didUpdatePresentableModel?(.init(showCancelButton: true,
                                         showReloadButton: false,
                                         showWebView: true,
                                         canGoBack: currentPresentableModel.canGoBack,
                                         canGoForward: currentPresentableModel.canGoForward,
                                         progressBar: value))
    }
}
