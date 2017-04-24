import Foundation

class HttpRequester: HttpRequesterBase {
    var delegate: HttpRequesterDelegate?
    let defaultIdentifier: String = "__identifier__"
    
    func send(withCRUDMethod crudMethod: HttpCRUDMethod, toUrl urlString: String, withBody body: Any?, andHeaders headers: Dictionary<String, String>, identifier: String) {
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = self.mapCRUDMethodToHttpMethod(crudMethod)
        
        if (body != nil) {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted)
            } catch {
                // TODO: throw error
            }
        }
        
        headers.forEach() {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        weak var weakSelf = self
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                // TODO: throw error
            }
            
            if (crudMethod == HttpCRUDMethod.get) {
                weakSelf?.delegate?.didCompleteGet(result: data!, identifier: identifier)
            } else {
                do {
                    let parsedJSONData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    switch(crudMethod) {
                    case .getAllJSON:
                        weakSelf?.delegate?.didCompleteGetAllJSON(result: parsedJSONData, identifier: identifier)
                    case .getJSON:
                        weakSelf?.delegate?.didCompleteGetJSON(result: parsedJSONData, identifier: identifier)
                    case .postJSON:
                        weakSelf?.delegate?.didCompletePostJSON(result: parsedJSONData, identifier: identifier)
                    case .deleteJSON:
                        weakSelf?.delegate?.didCompleteDeleteJSON(result: parsedJSONData, identifier: identifier)
                    default:
                        break;
                    }
                    
                } catch {
                    // TODO: throw error
                }
            }
        }
        
        dataTask.resume()
    }
    
    func mapCRUDMethodToHttpMethod(_ crudMethod: HttpCRUDMethod) -> String {
        switch crudMethod {
        case .getAllJSON:
            return "GET"
        case .getJSON:
            return "GET"
        case .postJSON:
            return "POST"
        case .deleteJSON:
            return "DELETE"
        default:
            return crudMethod.rawValue
        }
    }
    
    func get(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .get, toUrl: urlString, withBody: nil, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func getAll(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .getAllJSON, toUrl: urlString, withBody: nil, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func getDetails(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .getJSON, toUrl: urlString, withBody: nil, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func post(toUrl urlString: String, withBody body: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .postJSON, toUrl: urlString, withBody: body, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func postJson(toUrl urlString: String, withBody body: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?) {
        var headersWithJson = headers ?? [:]
        headersWithJson["Content-Type"] = "application/json"
        
        self.send(withCRUDMethod: .postJSON, toUrl: urlString, withBody: body, andHeaders: headersWithJson, identifier: identifier ?? defaultIdentifier)
    }
    
    func delete(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?) {
        var headersWithJson = headers ?? [:]
        self.send(withCRUDMethod: .deleteJSON, toUrl: urlString, withBody: nil, andHeaders: headersWithJson, identifier	: identifier ?? defaultIdentifier)
    }
}

