import UIKit

class AgentsMasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AgentsDatadelegate {
    var agentsData: AgentsData?
    var agents: [Agent] = []
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "AgentTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "agent-cell")
        self.tableView.rowHeight = 120
        
        self.showLoading()
        self.agentsData?.getAll(cookie: self.cookie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAgents(agents: [Agent], error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.agents = agents
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
        return self.agents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agent-cell", for: indexPath) as! AgentTableViewCell
        let currentAgent = self.agents[indexPath.row]
        cell.vLabelFullName.text = "\(currentAgent.firstName) \(currentAgent.lastName)"
        cell.vLabelCompany.text = currentAgent.company ?? "Unknown"
        cell.vLabelPhone.text = currentAgent.phone
        cell.vLabelRating.text = currentAgent.rating.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let agentDetailedVC = storyBoard.instantiateViewController(withIdentifier: "agentDetails") as! AgentDetailsViewController
        agentDetailedVC.agentId = self.agents[indexPath.row].id
        self.navigationController!.pushViewController(agentDetailedVC, animated: true)
    }
}
