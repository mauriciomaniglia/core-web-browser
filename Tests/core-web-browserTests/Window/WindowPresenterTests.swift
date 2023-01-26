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

    func didStartEditing() {
        didUpdatePresentableModel?(.init(showCancelButton: true,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }

    func didEndEditing() {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: false,
                                         showWebView: false,
                                         canGoBack: false,
                                         canGoForward: false,
                                         progressBar: nil))
    }

    func didLoadPage(canGoBack: Bool, canGoForward: Bool) {
        didUpdatePresentableModel?(.init(showCancelButton: false,
                                         showReloadButton: true,
                                         showWebView: true,
                                         canGoBack: canGoBack,
                                         canGoForward: canGoForward,
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

    func test_didStartEditing_deliversCorrectValues() {
        let sut = WindowPresenter()
        var receivedResult: WindowPresentableModel?
        sut.didUpdatePresentableModel = { receivedResult = $0 }

        sut.didStartEditing()

        XCTAssertTrue(receivedResult!.showCancelButton)
        XCTAssertFalse(receivedResult!.showReloadButton)
        XCTAssertFalse(receivedResult!.showWebView)
        XCTAssertFalse(receivedResult!.canGoBack)
        XCTAssertFalse(receivedResult!.canGoForward)
        XCTAssertNil(receivedResult!.progressBar)
    }

    func test_didEndEditing_deliversCorrectValues() {
        let sut = WindowPresenter()
        var receivedResult: WindowPresentableModel?
        sut.didUpdatePresentableModel = { receivedResult = $0 }

        sut.didEndEditing()

        XCTAssertFalse(receivedResult!.showCancelButton)
        XCTAssertFalse(receivedResult!.showReloadButton)
        XCTAssertFalse(receivedResult!.showWebView)
        XCTAssertFalse(receivedResult!.canGoBack)
        XCTAssertFalse(receivedResult!.canGoForward)
        XCTAssertNil(receivedResult!.progressBar)
    }

    func test_didLoadPage_deliversCorrectValues() {
        let sut = WindowPresenter()
        var receivedResult: WindowPresentableModel?
        sut.didUpdatePresentableModel = { receivedResult = $0 }

        sut.didLoadPage(canGoBack: true, canGoForward: true)

        XCTAssertFalse(receivedResult!.showCancelButton)
        XCTAssertTrue(receivedResult!.showReloadButton)
        XCTAssertTrue(receivedResult!.showWebView)
        XCTAssertTrue(receivedResult!.canGoBack)
        XCTAssertTrue(receivedResult!.canGoForward)
        XCTAssertNil(receivedResult!.progressBar)
    }
}
