import Foundation

extension Review {
    func toDict() -> Dictionary<String, Any> {
        return [
            "addId": self.addId,
            "addRating": self.addRating,
            "addNote": self.addNote ?? "No addvert note",
            "agentId": self.agentId,
            "agentRating": self.agentRating,
            "agentNote": self.agentNote ?? "No agent note",
            "compass": self.compass,
            "latitude": self.latitude,
            "longitude": self.longitude
        ]
    }
}
