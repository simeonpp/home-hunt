import Foundation

class UsersData: HttpRequesterDelegate {
    var url: String?
    var httpRequester: HttpRequesterBase?
    var delegate: UsersDataDelegate?
    
    func register(user: User) {
        self.httpRequester?.postJson(toUrl: "\(self.url!)/register", withBody: user.toDict(), andHeaders: nil, identifier: UsersDataIdentifiers.register.rawValue)
    }
    
    func login(user: User) {
        self.httpRequester?.postJson(toUrl: "\(self.url!)/login", withBody: user.toDict(), andHeaders: nil, identifier: UsersDataIdentifiers.login.rawValue)
    }
    
    func didCompletePostJSON(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        switch identifier {
        case UsersDataIdentifiers.register.rawValue:
            let user = User(withDict: resultAsDict)
            self.delegate?.didRegistered(user: user)
        case UsersDataIdentifiers.login.rawValue:
            let error = resultAsDict["error"]
            if (error == nil) {
                self.delegate?.didLogin(cookie: resultAsDict["cookie"]! as! String, error: nil)
            } else {
                let errorDict = error as! Dictionary<String, Any>
                let errorMessage = errorDict["message"] as! String
                self.delegate?.didLogin(cookie: "__no_cookie__", error: errorMessage)
            }
        default:
            return
        }
    }
}
