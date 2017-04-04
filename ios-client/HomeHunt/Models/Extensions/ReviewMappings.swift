import Foundation

extension Review {
    func toDict() -> Dictionary<String, Any> {
        return [
            "addId": self.addId,
            "addRating": self.addRating,
            "addNote": self.addNote,
            "agentId": self.agentId,
            "agentRating": self.agentRating,
            "agentNote": self.agentNote
        ]
    }
}
