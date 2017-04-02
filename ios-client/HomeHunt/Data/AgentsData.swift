import Foundation

class AgentsData: BaseData, HttpRequesterDelegate {
    var url: String?
    var httpRequester: HttpRequesterBase?
    var delegate: AgentsDatadelegate?
    
    func getAll(cookie: String) {
        self.httpRequester?.getAll(fromUrl: self.url!, withHeaders: self.getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func get(agentId: Int, cookie: String) {
        let newUrl = "\(self.url!)/\(agentId)"
        self.httpRequester?.getDetails(fromUrl: newUrl, withHeaders: getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func didCompleteGetAll(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            let agents = (resultAsDict["result"] as! [Dictionary<String, Any>])
                .map(){ Agent(withDict: $0) }
            self.delegate?.didReceiveAgents(agents: agents, error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didReceiveAgents(agents: [], error: apiError)
        }
    }
    
    func didCompleteGet(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            let agent = Agent(withDict: resultAsDict["result"] as! Dictionary<String, Any>)
            self.delegate?.didReceiveAgent(agent: agent, error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didReceiveAgent(agent: nil, error: apiError)
        }
    }
}
