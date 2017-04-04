import Foundation

extension Appointment {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let id = dict["id"] as? Int
        let addId = dict["addId"] as? Int
        let agentId = dict["agentId"] as? Int
        let status = dict["status"] as! String
        let timestamp = dict["date"] as! Int
        let note = dict["note"] as? String
        
        self.init(withId: id,
            andStatus: status,
            andNote: note,
            andTimestamp: timestamp,
            andAddId: addId,
            andAgentId: agentId)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "id": self.id!,
            "timestamp": self.timestamp,
            "note": self.note
        ]
    }
}
