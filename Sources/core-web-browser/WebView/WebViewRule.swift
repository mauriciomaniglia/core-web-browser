public enum WebViewRule: String {
    case advertising
    case analytics
    case social
    case cryptomining
    case fingerprinting

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
        }
    }
}
