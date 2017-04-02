import Foundation

class Agent {
    var id: Int?
    var firstName: String
    var lastName: String
    var phone: String
    var email: String?
    var company: String?
    var rating: Float
    var ratingCount: Int
    var website: String?
    var notes: [String]
    
    init(withId id: Int?,
         andFirstName firstName: String,
         andLastName lastName: String,
         andPhone phone: String,
         andEmail email: String?,
         andCompany company: String?,
         andRating rating: Float,
         andRatingCount ratingCount: Int,
         andWebsite website: String?,
         andNotes notes: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.company = company
        self.rating = rating
        self.ratingCount = ratingCount
        self.website = website
        self.notes = notes
    }
}
