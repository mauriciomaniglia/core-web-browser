public class RulesProvider {
    public init() {}

    public func advertising() -> (name: String, content: String) {
        return ("advertising", advertisingRules)
    }

    public func analytics() -> (name: String, content: String) {
        return ("analytics", analyticsRules)
    }

    public func social() -> (name: String, content: String) {
        return ("social", socialRules)
    }

    public func cryptomining() -> (name: String, content: String) {
        return ("cryptomining", cryptominingRules)
    }

    public func fingerprinting() -> (name: String, content: String) {
        return ("fingerprinting", fingerprintingRules)
    }

    public func advertisingCookies() -> (name: String, content: String) {
        return ("advertisingCookies", cookiesAdvertisingRules)
    }

    public func analyticsCookies() -> (name: String, content: String) {
        return ("analyticsCookies", cookiesAnalyticsRules)
    }

    public func socialCookies() -> (name: String, content: String) {
        return ("socialCookies", cookiesSocialRules)
    }
}
