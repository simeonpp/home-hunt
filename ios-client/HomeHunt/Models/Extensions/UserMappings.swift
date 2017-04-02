import Foundation

extension User {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let currentUsername = dict["username"] as! String
        let currentPassword = (dict["password"] ?? "___") as! String
        self.init(withUsername: currentUsername, andPassword: currentPassword)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "username": self.username!,
            "password": self.password!
        ]
    }
}
