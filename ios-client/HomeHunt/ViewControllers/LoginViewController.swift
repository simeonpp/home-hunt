import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var vTextFieldUsername: UITextField!
    @IBOutlet weak var vTextFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "homeNavigation")
        self.present(homeVC, animated: false, completion: nil)
//        self.navigationController!.pushViewController(homeVC, animated: true)
    }
}
