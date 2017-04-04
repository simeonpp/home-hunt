import UIKit

class AddDetailsViewController: UIViewController, UITableViewDataSource, AddDataDelegate {
    var addId: Int?
    var addData: AddData?
    var add: Add?
        
    @IBOutlet weak var vImage: ImageWithLoadingView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vLabelType: UILabel!
    @IBOutlet weak var vLabelStatus: UILabel!
    @IBOutlet weak var vLabelRating: UILabel!
    @IBOutlet weak var vLabelAddress: UILabel!
    @IBOutlet weak var vLabelDescription: UILabel!
    @IBOutlet weak var vLabelAgentName: UILabel!
    @IBOutlet weak var vLabelAgentPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register table cell for notes
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "add-comment-cell")
        
        self.showLoading()
        self.addData?.get(addId: self.addId!, cookie: self.cookie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAdd(add: Add?, error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.add = add
                self.updateDetailLabels()
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
    
    func updateDetailLabels() {
        let ratingString = "\((self.add?.rating.description)!) / \((self.add?.ratingCount)!)"
        let addressString = "\((self.add?.town)!), \((self.add?.address)!)"
        
        self.vImage.imageUrl = self.add?.imageFilename
        self.vLabelType.text = self.add?.type
        self.vLabelStatus.text = self.add?.status
        self.vLabelStatus.textColor = StatusColorHelper.getStatusColor(status: self.add!.status as! String)
        self.vLabelRating.text = ratingString
        self.vLabelAddress.text = addressString
        self.vLabelDescription.text = self.add?.description ?? "None"
        
        // Agent info
        self.vLabelAgentName.text = "\((self.add?.agentFirstName)!) \((self.add?.agentLastName)!)"
        self.vLabelAgentPhone.text = self.add?.agentPhone
        
        self.tableView.reloadData()
    }
    
    @IBAction func viewAgentInformation(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let agentDetailedVC = storyBoard.instantiateViewController(withIdentifier: "agentDetails") as! AgentDetailsViewController
        agentDetailedVC.agentId = self.add?.agentId
        self.navigationController!.pushViewController(agentDetailedVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.add?.notes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add-comment-cell", for: indexPath)
        cell.textLabel?.text = self.add?.notes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    @IBAction func addAppointment(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let createAppointmentVC = storyBoard.instantiateViewController(withIdentifier: "addNewAppointment") as! CreateAppointmentViewController
        createAppointmentVC.addId = self.addId
        self.navigationController!.pushViewController(createAppointmentVC, animated: true)
    }
}
