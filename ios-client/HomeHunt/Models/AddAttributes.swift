import Foundation

class AddAttributes {
    var type: String
    var displayName: String
    var value: String
    
    init(withType type: String,
         andDisplayName displayName: String,
         andValue value: String) {
        self.type = type
        self.displayName = displayName
        self.value = value
    }
}
