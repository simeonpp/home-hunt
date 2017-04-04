import Foundation

class ApiError {
    var type: String
    var message: String
    
    init(withType type: String, andMessage message: String) {
        self.type = type
        self.message = message
    }
}
