import Foundation

public class WhitelistStore {
    public static func isRegisteredDomain(_ domain: String) -> Bool {
        let whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        return whitelist.contains(domain)
    }

    public static func saveDomain(_ domain: String) {
        var whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        if !whitelist.contains(domain) {
            whitelist.append(domain)
            UserDefaults.standard.set(whitelist, forKey: "Whitelist")
        }
    }

    public static func removeDomain(_ domain: String) {
        var whitelist = UserDefaults.standard.stringArray(forKey: "Whitelist") ?? []

        if let index = whitelist.firstIndex(of: domain) {
            whitelist.remove(at: index)
            UserDefaults.standard.set(whitelist, forKey: "Whitelist")
        }
    }
}
