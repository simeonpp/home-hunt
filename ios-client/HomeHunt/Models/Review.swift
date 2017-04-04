import Foundation

class Review {
    var addId: Int
    var agentId: Int
    var addRating: Int
    var agentRating: Int
    var addNote: String?
    var agentNote: String?
    
    init(withAddId addId: Int,
         andAgentId agentId: Int,
         andAddRating addRating: Int,
         andAgentRating agentRating: Int,
         andAddNote addNote: String?,
         andAgentNote agentNote: String?) {
        self.addId = addId
        self.agentId = agentId
        self.addRating = addRating
        self.agentRating = agentRating
        self.addNote = addNote
        self.agentNote = agentNote
    }
}
