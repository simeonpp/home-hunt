import UIKit

class AppointmentDetailsViewController: UIViewController, AppointmentDataDelegate {
    var appointmentId: Int?
    var appointmentData: AppointmentData?
    var appointment: Appointment?
    
    @IBOutlet weak var vLabelDate: UILabel!
    @IBOutlet weak var vLabelStatus: UILabel!
    @IBOutlet weak var vLabelNote: UILabel!
    @IBOutlet weak var vButtonFinish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        self.appointmentData?.get(appointmentId: self.appointmentId!, cookie: self.cookie)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAppointment(appointment: Appointment?, error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.appointment = appointment
                self.updateDetailLabels()
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
    
    func updateDetailLabels() -> Void {
        self.vLabelDate.text = DateHelper.toStringUTC((self.appointment?.date)!)
        self.vLabelNote.text = self.appointment?.note
        
        self.vLabelStatus.text = self.appointment?.status
        self.vLabelStatus.textColor = StatusColorHelper.getAppointmentStatusColor(status: (self.appointment?.status!)!)
        
        if (self.appointment?.status != "Pending") {
            self.vButtonFinish.isHidden = true
        }
    }
    
    
    @IBAction func navigateToAddDetails(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addDetailedVC = storyBoard.instantiateViewController(withIdentifier: "addDetails") as! AddDetailsViewController
        addDetailedVC.addId = self.appointment?.addId
        self.navigationController!.pushViewController(addDetailedVC, animated: true)
    }
    
    @IBAction func navigateToAgentDetails(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let agentDetailedVC = storyBoard.instantiateViewController(withIdentifier: "agentDetails") as! AgentDetailsViewController
        agentDetailedVC.agentId = self.appointment?.agentId
        self.navigationController!.pushViewController(agentDetailedVC, animated: true)
    }
    
    @IBAction func addReview(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let reviewFormVC = storyBoard.instantiateViewController(withIdentifier: "reviewForm") as! SubmitReviewViewController
        reviewFormVC.appointmentId = self.appointmentId
        reviewFormVC.addId = self.appointment?.addId
        reviewFormVC.agentId = self.appointment?.agentId
        self.navigationController!.pushViewController(reviewFormVC, animated: true)
    }
}
