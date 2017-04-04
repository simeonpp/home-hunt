import UIKit

class AgentTableViewCell: UITableViewCell {
    @IBOutlet weak var vLabelFullName: UILabel!
    @IBOutlet weak var vLabelCompany: UILabel!
    @IBOutlet weak var vLabelPhone: UILabel!
    @IBOutlet weak var vLabelRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        if (selected) {
//            self.backgroundColor = .black
//        } else {
//            self.backgroundColor = .white
//        }
    }
    
}
