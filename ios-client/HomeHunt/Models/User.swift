import Foundation

class User {
    var username: String?
    var password: String?
    
    init(withUsername username: String, andPassword password: String) {
        self.username = username
        self.password = password
    }
}
