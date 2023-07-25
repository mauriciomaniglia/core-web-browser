public enum BlockingRule: String {
    case advertising
    case analytics
    case social
    case cryptomining
    case fingerprinting
    case advertisingCookies
    case analyticsCookies
    case socialCookies

    func content() -> String {
        switch self {
        case .advertising:
            return advertisingRules
        case .analytics:
            return analyticsRules
        case .social:
            return socialRules
        case .cryptomining:
            return cryptominingRules
        case .fingerprinting:
            return fingerprintingRules
        case .advertisingCookies:
            return cookiesAdvertisingRules
        case .analyticsCookies:
            return cookiesAnalyticsRules
        case .socialCookies:
            return cookiesSocialRules
        }
    }
}
