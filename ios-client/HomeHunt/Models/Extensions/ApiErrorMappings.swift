import Foundation

extension ApiError {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let currentType = dict["type"] as! String
        let currentMessage = dict["message"] as! String
        self.init(withType: currentType, andMessage: currentMessage)
    }
}
