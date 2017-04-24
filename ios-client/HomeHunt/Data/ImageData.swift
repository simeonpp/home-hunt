import Foundation

class ImageData: HttpRequesterDelegate {
    var url: String?
    var httpRequester: HttpRequesterBase?
    var delegate: ImageDataDelegate?
    
    func getImage(filename: String) {
        let url = "\(self.url!)/\(filename)"
        self.httpRequester?.get(fromUrl: url, withHeaders: nil, identifier: nil)
    }
    
    func didCompleteGet(result: Data, identifier: String) {
        self.delegate?.didReceiveImage(image: result, error: nil)
    }
}
