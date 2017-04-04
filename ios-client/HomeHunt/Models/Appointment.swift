import Foundation

class Appointment {
    var id: Int?
    var status: String?
    var note: String?
    var timestamp: Int
    var addId: Int?
    var agentId: Int?
    
    convenience init(withId id: Int, andTimestamp timestamp: Int, andNote note: String) {
        self.init(withId: id, andStatus: nil, andNote: note, andTimestamp: timestamp, andAddId: nil, andAgentId: nil)
    }
    
    init(withId id: Int?,
         andStatus status: String?,
         andNote note: String?,
         andTimestamp timestamp: Int,
         andAddId addId: Int?,
         andAgentId agentId: Int?) {
        self.id = id
        self.status = status
        self.note = note
        self.timestamp = timestamp
        self.addId = addId
        self.agentId = agentId
    }
}
