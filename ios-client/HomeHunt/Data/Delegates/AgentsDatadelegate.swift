import Foundation

protocol AgentsDatadelegate {
    func didReceiveAgents(agents: [Agent], error: ApiError?)
    func didReceiveAgent(agent: Agent?, error: ApiError?)
}

extension AgentsDatadelegate {
    func didReceiveAgents(agents: [Agent], error: ApiError?) {
        
    }
    
    func didReceiveAgent(agent: Agent?, error: ApiError?) {
        
    }
}
