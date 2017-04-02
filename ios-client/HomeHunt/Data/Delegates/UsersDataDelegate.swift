import Foundation

protocol UsersDataDelegate {
    func didRegistered(user: User)
    func didLogin(cookie: String)
}

extension UsersDataDelegate {
    func didRegistered(user: User) {
        
    }
    
    func didLogin(cookie: String) {
        
    }
}

