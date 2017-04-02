import UIKit

class AgentDetailsViewController: UIViewController, UITableViewDataSource, AgentsDatadelegate {
    var agentId: Int?
    var agentData: AgentsData?
    var agent: Agent?
    
    @IBOutlet weak var vLabelFullname: UILabel!
    @IBOutlet weak var vLabelPhone: UILabel!
    @IBOutlet weak var vLabelEmail: UILabel!
    @IBOutlet weak var vLabelCompany: UILabel!
    @IBOutlet weak var vLabelRating: UILabel!
    @IBOutlet weak var vLabelWebsite: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "agent-comment-cell")
        
        self.showLoading()
        self.agentData?.get(agentId: self.agentId!, cookie: self.cookie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAgent(agent: Agent?, error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.agent = agent
                self.updateDetailLabels()
            } else {
                weakSelf.handleApiRequestError(error: error!)
            }
        }
    }
    
    func updateDetailLabels() {        
        self.vLabelFullname.text = "\((self.agent?.firstName)!) \((self.agent?.lastName)!)"
        self.vLabelPhone.text = self.agent?.phone
        self.vLabelEmail.text = self.agent?.email ?? "None"
        self.vLabelCompany.text = self.agent?.company ?? "None"
        self.vLabelRating.text = "\((self.agent?.rating)!) / \((self.agent?.ratingCount)!)"
        self.vLabelWebsite.text = self.agent?.website ?? "None"
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.agent?.notes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agent-comment-cell", for: indexPath)
        cell.textLabel?.text = self.agent?.notes[indexPath.row]        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
}
