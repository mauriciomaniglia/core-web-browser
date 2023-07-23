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
            return blockAdvertising
        case .analytics:
            return blockAnalytics
        case .social:
            return blockSocial
        case .cryptomining:
            return blockCryptomining
        case .fingerprinting:
            return blockFingerprinting
        case .advertisingCookies:
            return blockCookiesAdvertising
        case .analyticsCookies:
            return blockCookiesAnalytics
        case .socialCookies:
            return blockCookiesSocial
        }
    }
}
