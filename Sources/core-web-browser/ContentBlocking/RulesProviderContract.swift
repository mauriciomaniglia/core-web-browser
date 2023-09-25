public protocol RulesProviderContract {
    func advertising() -> (name: String, content: String)
    func analytics() -> (name: String, content: String)
    func social() -> (name: String, content: String)
    func cryptomining() -> (name: String, content: String)
    func fingerprinting() -> (name: String, content: String)
    func advertisingCookies() -> (name: String, content: String)
    func analyticsCookies() -> (name: String, content: String)
    func socialCookies() -> (name: String, content: String)
}
