import Foundation

struct Environment {
    
    static func apiBaseUrl() -> String {
        guard let url = ProcessInfo.processInfo.environment["api_base_url"] else {
            fatalError("Environment variable is not defined: api_base_url")
        }
        
        return url
    }

}
