import XCTest
import core_web_browser

class WhitelistStore {
    static func isRegisteredDomain(_ domain: String) -> Bool {
        let whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        return whitelist.contains(domain)
    }

    static func saveDomain(_ domain: String) {
        UserDefaults.standard.set([domain], forKey: "Whitelist")
    }
}

class WhitelistStoreTests: XCTestCase {
    override func tearDown() {
        UserDefaults.standard.set([], forKey: "Whitelist")
    }

    func test_isRegisteredDomain_whenListIsEmptyReturnsFalse() {
        XCTAssertFalse(WhitelistStore.isRegisteredDomain("www.apple.com"))
    }

    func test_saveDomain_whenListIsEmptySavesTheNewDomain() {
        XCTAssertFalse(WhitelistStore.isRegisteredDomain("www.apple.com"))

        WhitelistStore.saveDomain("www.apple.com")

        XCTAssertTrue(WhitelistStore.isRegisteredDomain("www.apple.com"))
    }
}
