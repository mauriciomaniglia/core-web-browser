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
            return BlockingRuleContent.advertising
        case .analytics:
            return BlockingRuleContent.analytics
        case .social:
            return BlockingRuleContent.social
        case .cryptomining:
            return BlockingRuleContent.cryptomining
        case .fingerprinting:
            return BlockingRuleContent.fingerprinting
        case .advertisingCookies:
            return BlockingRuleContent.cookiesAdvertising
        case .analyticsCookies:
            return BlockingRuleContent.cookiesAnalytics
        case .socialCookies:
            return BlockingRuleContent.cookiesSocial
        }
    }
}
