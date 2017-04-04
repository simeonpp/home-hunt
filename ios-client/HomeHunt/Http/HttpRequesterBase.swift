import Foundation

protocol HttpRequesterBase {
    var delegate: HttpRequesterDelegate? {get set}
    
    // makes get request and returns plain data
    func get(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    // makes get request and returns parsed data as json
    func getAll(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    // makes get request and returns parsed data as json
    func getDetails(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    // makes post request with body and returns parsed data as json
    func post(toUrl urlString: String, withBody: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    // makes post request with body and header for json body and returns parsed data as json
    func postJson(toUrl urlString: String, withBody: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?)
    
    // makes delete request and returns parsed data as json
    func delete(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?)
}
