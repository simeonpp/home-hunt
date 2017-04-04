import UIKit

class StatusColorHelper {
    public static func getStatusColor(status: String) -> UIColor {
        var color: UIColor
        
        switch status {
        case "Visited":
            color = UIColor(red: 0, green: 0.5, blue: 0.2, alpha: 1)
        case "Not visited":
            color = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
        case "Liked":
            color = UIColor(red: 0, green: 0.6, blue: 1, alpha: 1)
        case "Dislike":
            color = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        case "Love":
            color = UIColor(red: 1, green: 0, blue: 0.95, alpha: 1)
        default:
            color = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        return color
    }
}
