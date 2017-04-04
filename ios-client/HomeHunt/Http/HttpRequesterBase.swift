import Foundation

protocol HttpRequesterBase {
    var delegate: HttpRequesterDelegate? {get set}
    
    func getAll(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    func getDetails(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    func post(toUrl urlString: String, withBody: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    func postJson(toUrl urlString: String, withBody: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?)
}
