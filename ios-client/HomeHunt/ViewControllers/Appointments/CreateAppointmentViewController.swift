import UIKit

class CreateAppointmentViewController: UIViewController, AppointmentDataDelegate {
    var addId: Int?
    var appointmentData: AppointmentData?
    
    @IBOutlet weak var vTextFieldNote: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.addId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createAppointment(_ sender: UIButton) {
        let timestamp = 1293683278
        let note = self.vTextFieldNote.text
        let appointmentToCreate = Appointment(withId: self.addId!, andTimestamp: timestamp, andNote: note!)
        
        self.showLoading()
        self.appointmentData?.create(appointment: appointmentToCreate, cookie: self.cookie)
    }
    
    func didCreate(error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.hideLoading()
                weakSelf.showInformDialog(withTitle: "Appointment added", andMessage: "Appointment successfully added", andHandler: { action in
                    self.vTextFieldNote.text = ""
                })
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
}
