import Foundation

struct ApiCreds {
    static let URL: String = {
        guard let urlString = ProcessInfo.processInfo.environment["API_URL"] else {
            fatalError("API_URL environment variable not set")
        }
        return urlString
    }()
    
    static let username: String = {
        guard let loginString = ProcessInfo.processInfo.environment["API_USERNAME"] else {
            fatalError("API_LOGIN environment variable not set")
        }
        return loginString
    }()
    
    static let password: String = {
        guard let passwordString = ProcessInfo.processInfo.environment["API_PASSWORD"] else {
            fatalError("API_PASSWORD environment variable not set")
        }
        return passwordString
    }()
}
