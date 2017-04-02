import UIKit

class AddsMasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddDataDelegate {
    var addsData: AddData?
    var adds: [Add] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "AddTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "add-cell")
        self.tableView.rowHeight = 114
        
        self.showLoading()
        self.addsData?.getAll(cookie: self.cookie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceiveAdds(adds: [Add], error: ApiError?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            if (error == nil) {
                weakSelf.adds = adds
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
        return self.adds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "add-cell", for: indexPath) as! AddTableViewCell
        let currentAdd = self.adds[indexPath.row]
        
        cell.vLabelType.text = currentAdd.type
        cell.vLabelStatus.text = currentAdd.status
        cell.vLabelStatus.textColor = StatusColorHelper.getStatusColor(status: currentAdd.status as! String)
        cell.vLabelAddress.text = "\(currentAdd.town), \(currentAdd.address)"
        cell.vLabelAgentName.text = "\(currentAdd.agentFirstName) \(currentAdd.agentLastName)"
        cell.vLabelAgentPhone.text = currentAdd.agentPhone
        cell.vLabelRating.text = currentAdd.rating.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addDetailedVC = storyBoard.instantiateViewController(withIdentifier: "addDetails") as! AddDetailsViewController
        addDetailedVC.addId = self.adds[indexPath.row].id
        self.navigationController!.pushViewController(addDetailedVC, animated: true)
    }
}
