import Foundation

protocol UsersDataDelegate {
    func didRegistered(user: User)
    func didLogin(cookie: String, error: String?)
}

extension UsersDataDelegate {
    func didRegistered(user: User) {
        
    }
    
    func didLogin(cookie: String, error: String?) {
        
    }
}

