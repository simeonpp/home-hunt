import UIKit

class SubmitReviewViewController: UIViewController, ReviewDataDelegate {
    var reviewData: ReviewData?
    var appointmentId: Int?
    var addId: Int?
    var agentId: Int?
    
    @IBOutlet weak var vTextFieldAddComment: UITextView!
    @IBOutlet weak var vSliderAddRating: UISlider!
    @IBOutlet weak var vTextFieldAgentComment: UITextView!
    @IBOutlet weak var vSliderAgentRating: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let addRating = 5
        let agentRating = 2
        
        let review = Review(withAddId: self.addId!,
                            andAgentId: self.agentId!,
                            andAddRating: addRating,
                            andAgentRating: agentRating,
                            andAddNote: self.vTextFieldAgentComment.text,
                            andAgentNote: self.vTextFieldAgentComment.text)
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
