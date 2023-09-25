import core_web_browser

class RulesProviderSpy: RulesProviderContract {
    enum Message: Equatable {
        case advertising
        case analytics
        case social
        case cryptomining
        case fingerprinting
        case advertisingCookies
        case analyticsCookies
        case socialCookies
    }

    var receivedMessages = [Message]()

    func advertising() -> (name: String, content: String) {
        receivedMessages.append(.advertising)

        return ("advertising", "advertising content")
    }

    func analytics() -> (name: String, content: String) {
        receivedMessages.append(.analytics)

        return ("analytics", "analytics content")
    }

    func social() -> (name: String, content: String) {
        receivedMessages.append(.social)

        return ("social", "social content")
    }

    func cryptomining() -> (name: String, content: String) {
        receivedMessages.append(.cryptomining)

        return ("cryptomining", "cryptomining content")
    }

    func fingerprinting() -> (name: String, content: String) {
        receivedMessages.append(.fingerprinting)

        return ("fingerprinting", "fingerprinting content")
    }

    func advertisingCookies() -> (name: String, content: String) {
        receivedMessages.append(.advertisingCookies)

        return ("advertisingCookies", "advertisingCookies content")
    }

    func analyticsCookies() -> (name: String, content: String) {
        receivedMessages.append(.analyticsCookies)

        return ("analyticsCookies", "analyticsCookies content")
    }

    func socialCookies() -> (name: String, content: String) {
        receivedMessages.append(.socialCookies)

        return ("socialCookies", "socialCookies content")
    }
}
