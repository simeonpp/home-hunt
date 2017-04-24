import Foundation

extension Add {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let id = dict["id"] as? Int
        let type = dict["type"] as! String
        let status = dict["status"] as! String
        let rating = dict["rating"] as! Float
        let ratingCount = dict["ratingCount"] as! Int
        let description = dict["description"] as? String
        let town = dict["town"] as! String
        let address = dict["address"] as! String
        let agentId = dict["agentId"] as? Int
        let agentFirstName = dict["agentFirstName"] as! String
        let agentLastName = dict["agentLastName"] as! String
        let agentPhone = dict["agentPhone"] as! String
        let imageFilename = dict["imageFilename"] as? String
        
        var notes: [String] = []
        if (dict["notes"] != nil) {
            let notesFromDict = dict["notes"] as! [Dictionary<String, Any>]
            for note in notesFromDict {
                notes.append(note["note"] as! String)
            }
        }
        
        var attributes: [AddAttributes] = []
        if (dict["attributes"] != nil) {
            let attributesFromDict = dict["attributes"] as! [Dictionary<String, Any>]
            for attributeDict in attributesFromDict {
                let attribute = AddAttributes.init(withDict: attributeDict)
                attributes.append(attribute)
            }
        }
        
        self.init(withId: id,
                  andType: type,
                  andStatus: status,
                  andRating: rating,
                  andRatingCount: ratingCount,
                  andDescription: description,
                  andTown: town,
                  andAddress: address,
                  andAgentId: agentId,
                  andAgentFirstName: agentFirstName,
                  andAgentLastName: agentLastName,
                  andAgentPhone: agentPhone,
                  andImageFilename: imageFilename,
                  andNotes: notes,
                  andAttributes: attributes)
    }
}
