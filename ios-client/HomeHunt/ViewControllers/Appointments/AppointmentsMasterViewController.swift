import UIKit

class AppointmentsMasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AppointmentDataDelegate {
    var appointmentData: AppointmentData?
    var appointments: [Appointment] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "appointment-cell")
        
        self.showLoading()
        self.appointmentData?.getAll(cookie: self.cookie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAppointments(appointments: [Appointment], error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.appointments = appointments
                weakSelf.tableView.reloadData()
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointment-cell", for: indexPath)
        let currentAppointment = self.appointments[indexPath.row]
        
        let cellColor: UIColor = StatusColorHelper.getAppointmentStatusColor(status: currentAppointment.status!)
        
        let formattedDate = DateHelper.toStringUTC(currentAppointment.date)
        let cellText = "\(formattedDate) - \(currentAppointment.status!)"
        cell.backgroundColor = cellColor
        cell.textLabel?.text = cellText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let appointmentDetailedVC = storyBoard.instantiateViewController(withIdentifier: "appointmentDetails") as! AppointmentDetailsViewController
        appointmentDetailedVC.appointmentId = self.appointments[indexPath.row].id
        self.navigationController!.pushViewController(appointmentDetailedVC, animated: true)
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let clickedAppointment = self.appointments[indexPath.row]
            self.showLoading()
            self.appointmentData?.delete(appointmentId: clickedAppointment.id!, cookie: self.cookie)
        }
     }
    
    func didDelete(error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            if (error == nil) {
                weakSelf.hideLoading()
                weakSelf.showInformDialog(withTitle: "Appointment deleted", andMessage: "Appointment was successfully deleted", andHandler: { action in
                        weakSelf.appointmentData?.getAll(cookie: self.cookie)
                })
            } else {
                weakSelf.hideLoading()
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
 
}
