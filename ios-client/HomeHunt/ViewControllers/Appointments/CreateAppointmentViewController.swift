import UIKit

class CreateAppointmentViewController: UIViewController, AppointmentDataDelegate {
    var addId: Int?
    var appointmentData: AppointmentData?
        
    @IBOutlet weak var vTextDate: UITextField!
    @IBOutlet weak var vTextNote: UITextView!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        print(self.addId!)
    }
    
    // Date picker
    func createDatePicker() {
        // format for picker
        datePicker.datePickerMode = .dateAndTime
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDonePress))
        toolbar.setItems([doneButton], animated: false)
        
        vTextDate.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        vTextDate.inputView = datePicker
    }
    
    func datePickerDonePress() {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        vTextDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // End date picker
    
    @IBAction func createAppointment(_ sender: UIButton) {
        let date = datePicker.date
        let note = self.vTextNote.text
        let appointmentToCreate = Appointment(withId: self.addId!, andDate: date, andNote: note!)
        
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
                    self.vTextNote.text = ""
                    self.vTextDate.text = ""
                })
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
}
