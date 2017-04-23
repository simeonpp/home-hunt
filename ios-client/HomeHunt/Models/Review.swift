import Foundation

class Review {
    var addId: Int
    var agentId: Int
    var addRating: Int
    var agentRating: Int
    var addNote: String?
    var agentNote: String?
    var compass: Int
    var latitude: Double
    var longitude: Double
    
    init(withAddId addId: Int,
         andAgentId agentId: Int,
         andAddRating addRating: Int,
         andAgentRating agentRating: Int,
         andAddNote addNote: String?,
         andAgentNote agentNote: String?,
         andCompass compass: Int,
         andLatitude latitude: Double,
         andLongitude longitude: Double) {
        self.addId = addId
        self.agentId = agentId
        self.addRating = addRating
        self.agentRating = agentRating
        self.addNote = addNote
        self.agentNote = agentNote
        self.compass = compass
        self.latitude = latitude
        self.longitude = longitude
    }
}
