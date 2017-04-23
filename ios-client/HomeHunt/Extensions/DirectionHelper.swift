import Foundation

class DirectionHelper {
    public static func getDirectionString(_ directionNumber: Int) -> String {
        // 0 - north, 90 - east, 180 - south, 270 - west
        if (directionNumber < 30) {
            return "N"
        } else if (directionNumber < 60) {
            return "NE"
        } else if (directionNumber < 120) {
            return "E"
        } else if (directionNumber < 150) {
            return "SE"
        } else if (directionNumber < 210) {
            return "S"
        } else if (directionNumber < 240) {
            return "WS"
        } else if (directionNumber < 300) {
            return "W"
        } else if (directionNumber < 330) {
            return "WN"
        } else {
            return "N"
        }
    }
}
