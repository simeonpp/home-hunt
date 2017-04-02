import Foundation

class BaseData {
    func getAuthenticationHeaders(cookie: String) -> Dictionary<String, String> {
        let headers: Dictionary<String, String> = [
            "x-cookie": cookie
        ]
        return headers;
    }
}
