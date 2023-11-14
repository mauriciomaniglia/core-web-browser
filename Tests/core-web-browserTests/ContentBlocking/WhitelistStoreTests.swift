import XCTest
import core_web_browser

class WhitelistStore {
    static func isRegisteredDomain(_ domain: String) -> Bool {
        return false
    }
}

class WhitelistStoreTests: XCTestCase {

    func test_isRegisteredDomain_whenListIsEmptyReturnsFalse() {
        XCTAssertFalse(WhitelistStore.isRegisteredDomain("www.apple.com"))
    }
}
