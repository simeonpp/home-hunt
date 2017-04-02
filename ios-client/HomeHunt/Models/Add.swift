import Foundation

class Add {
    var id: Int?
    var type: String
    var status: String
    var rating: Float
    var ratingCount: Int
    var description: String?
    var town: String
    var address: String
    var agentId: Int?
    var agentFirstName: String
    var agentLastName: String
    var agentPhone: String
    var imageFilename: String?
    var notes: [String]
    
    init(withId id: Int?,
         andType type: String,
         andStatus status: String,
         andRating rating: Float,
         andRatingCount ratingCount: Int,
         andDescription description: String?,
         andTown town: String,
         andAddress address: String,
         andAgentId agentId: Int?,
         andAgentFirstName agentFirstName: String,
         andAgentLastName agentLastName: String,
         andAgentPhone agentPhone: String,
         andImageFilename imageFilename: String?,
         andNotes notes: [String]) {
        self.id = id
        self.type = type
        self.status = status
        self.rating = rating
        self.ratingCount = ratingCount
        self.description = description
        self.town = town
        self.address = address
        self.agentId = agentId
        self.agentFirstName = agentFirstName
        self.agentLastName = agentLastName
        self.agentPhone = agentPhone
        self.imageFilename = imageFilename
        self.notes = notes
    }
}
