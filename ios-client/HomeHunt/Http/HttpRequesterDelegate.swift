import Foundation

protocol HttpRequesterDelegate {
    func didCompleteGet(result: Data, identifier: String)
    func didCompleteGetAllJSON(result: Any, identifier: String)
    func didCompleteGetJSON(result: Any, identifier: String)
    func didCompletePostJSON(result: Any, identifier: String)
    func didCompleteDeleteJSON(result: Any, identifier: String)
}

extension HttpRequesterDelegate {
    func didCompleteGet(result: Data, identifier: String) {
        
    }
    
    func didCompleteGetAllJSON(result: Any, identifier: String) {
        
    }
    
    func didCompleteGetJSON(result: Any, identifier: String) {
        
    }
    
    func didCompletePostJSON(result: Any, identifier: String) {
        
    }
    
    func didCompleteDeleteJSON(result: Any, identifier: String) {
        
    }
}
