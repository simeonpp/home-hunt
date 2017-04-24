import UIKit
import CoreLocation

class SubmitReviewViewController: UIViewController, CLLocationManagerDelegate, ReviewDataDelegate {
    var locationManager: CLLocationManager!
    
    var reviewData: ReviewData?
    var appointmentId: Int?
    var addId: Int?
    var agentId: Int?
    let sliderStep: Float = 1
    
    var compassDirectionNumber: Int = 0
    var geoLat: Double = 0
    var geoLong: Double = 0
    
    @IBOutlet weak var vTextFieldAddComment: UITextView!
    @IBOutlet weak var vSliderAddRating: UISlider!
    @IBOutlet weak var vTextFieldAgentComment: UITextView!
    @IBOutlet weak var vSliderAgentRating: UISlider!
    @IBOutlet weak var vTextAddRatingSlider: UILabel!
    @IBOutlet weak var vTextAgentRatingSlider: UILabel!
    @IBOutlet weak var vTextCompassNumber: UILabel!
    @IBOutlet weak var vTextCompassDirection: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Option 1
        locationManager  = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        // Close keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SubmitReviewViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        geoLat = location.coordinate.latitude
        geoLong = location.coordinate.longitude
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let directionNumber = Int(newHeading.magneticHeading)
        self.vTextCompassNumber.text = directionNumber.description
        self.vTextCompassDirection.text = DirectionHelper.getDirectionString(directionNumber)
        compassDirectionNumber = directionNumber
    }
    
    @IBAction func addRatingChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / sliderStep) * sliderStep
        sender.value = roundedValue
        self.vTextAddRatingSlider.text = String("\(Int(roundedValue))/5")
    }
    
    @IBAction func agentRatingChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / sliderStep) * sliderStep
        sender.value = roundedValue
        self.vTextAgentRatingSlider.text = String("\(Int(roundedValue))/5")
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let addRating = Int(vSliderAddRating.value)
        let agentRating = Int(vSliderAgentRating.value)
        
        let review = Review(withAddId: self.addId!,
                            andAgentId: self.agentId!,
                            andAddRating: addRating,
                            andAgentRating: agentRating,
                            andAddNote: self.vTextFieldAddComment.text,
                            andAgentNote: self.vTextFieldAgentComment.text,
                            andCompass: self.compassDirectionNumber,
                            andLatitude: self.geoLat,
                            andLongitude: self.geoLong)
        self.showLoading()
        self.reviewData?.post(appointmentId: self.appointmentId!, review: review, cookie: self.cookie)
    }
    
    func didPost(error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.showInformDialog(withTitle: "Review saved", andMessage: "Your review was successfully saved", andHandler: { action in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeVC = storyBoard.instantiateViewController(withIdentifier: "home")
                    self.navigationController!.pushViewController(homeVC, animated: true)
                })
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
}
