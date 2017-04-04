import Foundation

class ReviewData: BaseData, HttpRequesterDelegate {
    var url: String?
    var httpRequester: HttpRequesterBase?
    var delegate: ReviewDataDelegate?
    
    func post(appointmentId: Int, review: Review, cookie: String) {
        let newUrl = "\(self.url!)/\(appointmentId)"
        self.httpRequester?.postJson(toUrl: newUrl, withBody: review.toDict(), andHeaders: self.getAuthenticationHeaders(cookie: cookie), identifier: nil)
    }
    
    func didCompletePostJSON(result: Any, identifier: String) {
        let resultAsDict = result as! Dictionary<String, Any>
        let error = resultAsDict["error"]
        
        if (error == nil) {
            self.delegate?.didPost(error: nil)
        } else {
            let errorDict = error as! Dictionary<String, Any>
            let apiError = ApiError(withDict: errorDict)
            self.delegate?.didPost(error: apiError)
        }
    }
}
