public class WindowPresenter {
    public var didUpdatePresentableModel: ((WindowPresentableModel) -> Void)?
    private var model: WindowPresentableModel

    public init() {
        model = WindowPresentableModel(
            showCancelButton: false,
            showReloadButton: false,
            showWebView: false,
            canGoBack: false,
            canGoForward: false)
    }

    public func didStartNewWindow() {
        didUpdatePresentableModel?(.init(
            showCancelButton: false,
            showReloadButton: false,
            showWebView: false,
            canGoBack: false,
            canGoForward: false))
    }

    public func didStartEditing() {
        let newModel = WindowPresentableModel(
            showCancelButton: true,
            showReloadButton: false,
            showWebView: model.showWebView,
            canGoBack: model.canGoBack,
            canGoForward: model.canGoForward)

        model = newModel
        didUpdatePresentableModel?(newModel)
    }

    public func didEndEditing() {
        let newModel = WindowPresentableModel(
            showCancelButton: false,
            showReloadButton: model.showReloadButton,
            showWebView: model.showWebView,
            canGoBack: model.canGoBack,
            canGoForward: model.canGoForward)

        model = newModel
        didUpdatePresentableModel?(newModel)
    }

    public func didLoadPage(canGoBack: Bool, canGoForward: Bool) {
        let newModel = WindowPresentableModel(
            showCancelButton: false,
            showReloadButton: true,
            showWebView: true,
            canGoBack: canGoBack,
            canGoForward: canGoForward)

        model = newModel
        didUpdatePresentableModel?(newModel)
    }

    public func didUpdateProgressBar(_ value: Double) {
        didUpdatePresentableModel?(.init(
            showCancelButton: true,
            showReloadButton: false,
            showWebView: true,
            canGoBack: model.canGoBack,
            canGoForward: model.canGoForward,
            progressBar: value))
    }
}
