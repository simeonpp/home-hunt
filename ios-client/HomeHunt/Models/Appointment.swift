import Foundation

class Appointment {
    var id: Int?
    var status: String?
    var note: String?
    var date: Date
    var addId: Int?
    var agentId: Int?
    
    convenience init(withId id: Int, andDate date: Date, andNote note: String) {
        self.init(withId: id, andStatus: nil, andNote: note, adnDate: date, andAddId: nil, andAgentId: nil)
    }
    
    init(withId id: Int?,
         andStatus status: String?,
         andNote note: String?,
         adnDate date: Date,
         andAddId addId: Int?,
         andAgentId agentId: Int?) {
        self.id = id
        self.status = status
        self.note = note
        self.date = date
        self.addId = addId
        self.agentId = agentId
    }
}
