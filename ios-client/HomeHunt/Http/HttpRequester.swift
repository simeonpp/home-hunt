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
            
            do {
                let obj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                switch(crudMethod) {
                case .getAll:
                    weakSelf?.delegate?.didCompleteGetAll(result: obj, identifier: identifier)
                case .get:
                        weakSelf?.delegate?.didCompleteGet(result: obj, identifier: identifier)
                case .post:
                    weakSelf?.delegate?.didCompletePost(result: obj, identifier: identifier)
                }
                
            } catch {
                // TODO: throw error
            }
        }
        
        dataTask.resume()
    }
    
    func mapCRUDMethodToHttpMethod(_ crudMethod: HttpCRUDMethod) -> String {
        switch crudMethod {
        case .getAll:
            return "GET"
        default:
            return crudMethod.rawValue
        }
    }
    
    func getAll(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .getAll, toUrl: urlString, withBody: nil, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func getDetails(fromUrl urlString: String, withHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .get, toUrl: urlString, withBody: nil, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func post(toUrl urlString: String, withBody body: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?) {
        let newHeaders = headers ?? [:]
        self.send(withCRUDMethod: .post, toUrl: urlString, withBody: body, andHeaders: newHeaders, identifier: identifier ?? defaultIdentifier)
    }
    
    func postJson(toUrl urlString: String, withBody body: Any, andHeaders headers: Dictionary<String, String>?, identifier: String?) {
        var headersWithJson = headers ?? [:]
        headersWithJson["Content-Type"] = "application/json"
        
        self.send(withCRUDMethod: .post, toUrl: urlString, withBody: body, andHeaders: headersWithJson, identifier: identifier ?? defaultIdentifier)
    }
}

