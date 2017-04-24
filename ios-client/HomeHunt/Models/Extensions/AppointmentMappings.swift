import Foundation

extension Appointment {
    convenience init(withDict dict: Dictionary<String, Any>) {
        let id = dict["id"] as? Int
        let addId = dict["addId"] as? Int
        let agentId = dict["agentId"] as? Int
        let status = dict["status"] as! String
        let date = DateHelper.toDate(dict["date"] as! String)
        let note = dict["note"] as? String
        
        self.init(withId: id,
            andStatus: status,
            andNote: note,
            adnDate: date,
            andAddId: addId,
            andAgentId: agentId)
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "id": self.id!,
            "dateAndTime": DateHelper.toString(self.date),
            "note": self.note
        ]
    }
}
