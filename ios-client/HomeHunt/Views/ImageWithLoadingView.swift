import UIKit

class ImageWithLoadingView: UIView, ImageDataDelegate {
    var loadingView: UIView?
    var imageView: UIImageView?
    var imageData: ImageData?
    
    var imageUrl: String? {
        willSet(imageUrl) {
            DispatchQueue.main.async {
                	self.loadingView?.isHidden = false
                self.imageView?.isHidden = true
            }
            self.imageData?.getImage(filename: imageUrl!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        self.imageData = ImageData()
        self.imageData?.httpRequester = HttpRequester()
        self.imageData?.httpRequester?.delegate = self.imageData
        self.imageData?.url = "http://192.168.0.103:8000/public/images"
        self.imageData?.delegate = self
        
        self.loadingView = UIActivityIndicatorView(frame: self.frame)
        self.loadingView?.isHidden = false
        
        self.imageView = UIImageView(frame: self.frame)
        self.imageView?.isHidden = true
        
        self.addSubview(self.loadingView!)
        self.addSubview(self.imageView!)
    }
    
    func didReceiveImage(image: Data, error: Any?) {
        DispatchQueue.main.async {
            self.imageView?.image = UIImage(data: image)
            self.loadingView?.isHidden = true
            self.imageView?.isHidden = false
        }
    }
    
}
