import Foundation

class AddData: BaseData, HttpRequesterDelegate {
    var url: String?
    var httpRequester: HttpRequesterBase?
    var delegate: AddDataDelegate?
    
    func getAll(cookie: String) {
        self.httpRequester?.getAll(fromUrl: self.url!, withHeaders: self.getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func get(addId: Int, cookie: String) {
        let newUrl = "\(self.url!)/\(addId)"
        self.httpRequester?.getDetails(fromUrl: newUrl, withHeaders: getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func didCompleteGetAll(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            let adds = (resultAsDict["result"] as! [Dictionary<String, Any>])
                .map(){ Add(withDict: $0) }
            self.delegate?.didReceiveAdds(adds: adds, error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didReceiveAdds(adds: [], error: apiError)
        }
    }
    
    func didCompleteGet(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            let add = Add(withDict: resultAsDict["result"] as! Dictionary<String, Any>)
            self.delegate?.didReceiveAdd(add: add, error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didReceiveAdd(add: nil, error: apiError)
        }
    }
}
