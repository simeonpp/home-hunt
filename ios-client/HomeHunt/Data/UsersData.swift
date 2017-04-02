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
    
    func didCompletePost(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        switch identifier {
        case UsersDataIdentifiers.register.rawValue:
            let user = User(withDict: resultAsDict)
            self.delegate?.didRegistered(user: user)
        case UsersDataIdentifiers.login.rawValue:
            self.delegate?.didLogin(cookie: resultAsDict["cookie"]! as! String)
        default:
            return
        }
    }
}
