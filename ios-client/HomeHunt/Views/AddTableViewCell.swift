import UIKit

class AddTableViewCell: UITableViewCell {
    @IBOutlet weak var vImage: ImageWithLoadingView!
    @IBOutlet weak var vLabelType: UILabel!
    @IBOutlet weak var vLabelStatus: UILabel!
    @IBOutlet weak var vLabelAddress: UILabel!
    @IBOutlet weak var vLabelAgentName: UILabel!
    @IBOutlet weak var vLabelAgentPhone: UILabel!
    @IBOutlet weak var vLabelRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
