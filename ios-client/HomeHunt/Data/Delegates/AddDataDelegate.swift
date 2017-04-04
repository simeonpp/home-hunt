import Foundation

protocol AddDataDelegate {
    func didReceiveAdds(adds: [Add], error: ApiError?)
    func didReceiveAdd(add: Add?, error: ApiError?)
}

extension AddDataDelegate {
    func didReceiveAdds(adds: [Add], error: ApiError?) {
        
    }
    
    func didReceiveAdd(add: Add?, error: ApiError?) {
        
    }
}
