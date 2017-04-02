import Foundation

extension Agent {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let id = dict["id"] as? Int
        let firstName = dict["firstName"] as! String
        let lastName = dict["lastName"] as! String
        let phone = dict["phone"] as! String
        let email = dict["email"] as? String
        let company = dict["company"] as? String
        let rating = dict["rating"] as! Float
        let ratingCount = dict["ratingCount"] as! Int
        let website = dict["website"] as? String
        
        var notes: [String] = []
        if (dict["notes"] != nil) {
            let notesFromDict = dict["notes"] as! [Dictionary<String, Any>]
            for note in notesFromDict {
                notes.append(note["note"] as! String)
            }
        }
        
        self.init(withId: id,
                  andFirstName: firstName,
                  andLastName: lastName,
                  andPhone: phone,
                  andEmail: email,
                  andCompany: company,
                  andRating: rating,
                  andRatingCount: ratingCount,
                  andWebsite: website,
                  andNotes: notes)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "id": self.id,
            "firstName": self.firstName,
            "lastName": self.lastName,
            "phone": self.phone,
            "email": self.email,
            "company": self.company,
            "rating": self.rating,
            "ratingCount": self.ratingCount,
            "website": self.website
        ]
    }
}
