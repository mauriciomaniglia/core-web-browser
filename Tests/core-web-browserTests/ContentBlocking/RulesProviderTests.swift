import XCTest
import core_web_browser

class RulesProviderTests: XCTestCase {
    
    func test_advertising_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.advertising().name, "advertising")
    }

    func test_analytics_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.analytics().name, "analytics")
    }

    func test_social_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.social().name, "social")
    }

    func test_cryptomining_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.cryptomining().name, "cryptomining")
    }

    func test_fingerprinting_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.fingerprinting().name, "fingerprinting")
    }

    func test_advertisingCookies_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.advertisingCookies().name, "advertisingCookies")
    }

    func test_analyticsCookies_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.analyticsCookies().name, "analyticsCookies")
    }

    func test_socialCookies_deliversCorrectName() {
        let sut = RulesProvider()

        XCTAssertEqual(sut.socialCookies().name, "socialCookies")
    }
}
