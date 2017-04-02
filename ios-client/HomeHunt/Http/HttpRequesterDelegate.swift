import Foundation

protocol HttpRequesterDelegate {
    func didCompleteGetAll(result: Any, identifier: String)
    func didCompleteGet(result: Any, identifier: String)
    func didCompletePost(result: Any, identifier: String)
}

extension HttpRequesterDelegate {
    func didCompleteGetAll(result: Any, identifier: String) {
        
    }
    
    func didCompleteGet(result: Any, identifier: String) {
        
    }
    
    func didCompletePost(result: Any, identifier: String) {
        
    }
}
