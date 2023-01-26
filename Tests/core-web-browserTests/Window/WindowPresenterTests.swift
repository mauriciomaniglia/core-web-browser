import XCTest

struct WindowPresentableModel {
    let showCancelButton: Bool
    let showReloadButton: Bool
    let showWebView: Bool
    let canGoBack: Bool
    let canGoForward: Bool
    let progressBar: Int?
}

class WindowPresenter {
    var didUpdatePresentableModel: ((WindowPresentableModel) -> Void)?

    func didStartNewWindow() {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }
}

class WindowPresenterTests: XCTestCase {

    func test_didStartNewWindow_deliversCorrectValues() {
        let sut = WindowPresenter()
        var receivedResult: WindowPresentableModel?
        sut.didUpdatePresentableModel = { receivedResult = $0 }

        sut.didStartNewWindow()

        XCTAssertFalse(receivedResult!.showCancelButton)
        XCTAssertFalse(receivedResult!.showReloadButton)
        XCTAssertFalse(receivedResult!.showWebView)
        XCTAssertFalse(receivedResult!.canGoBack)
        XCTAssertFalse(receivedResult!.canGoForward)
        XCTAssertNil(receivedResult!.progressBar)
    }
}
