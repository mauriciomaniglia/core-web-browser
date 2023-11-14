import XCTest
import core_web_browser

class WhitelistStore {
    static func isRegisteredDomain(_ domain: String) -> Bool {
        let whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        return whitelist.contains(domain)
    }

    static func saveDomain(_ domain: String) {
        var whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        if !whitelist.contains(domain) {
            whitelist.append(domain)
            UserDefaults.standard.set(whitelist, forKey: "Whitelist")
        }
    }

    static func removeDomain(_ domain: String) {
        var whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        if let index = whitelist.firstIndex(of: domain) {
            whitelist.remove(at: index)
            UserDefaults.standard.set(whitelist, forKey: "Whitelist")
        }
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

    func test_saveDomain_whenListIsNotEmptySavesTheNewDomain() {
        WhitelistStore.saveDomain("www.apple.com")
        WhitelistStore.saveDomain("www.google.com")

        XCTAssertTrue(WhitelistStore.isRegisteredDomain("www.apple.com"))
        XCTAssertTrue(WhitelistStore.isRegisteredDomain("www.google.com"))
    }

    func test_removeDomain_whenDomainIsRegisteredRemoveFromTheList() {
        WhitelistStore.saveDomain("www.apple.com")

        WhitelistStore.removeDomain("www.apple.com")

        XCTAssertFalse(WhitelistStore.isRegisteredDomain("www.apple.com"))
    }
}
