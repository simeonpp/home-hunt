import UIKit

class RegisterViewController: UIViewController, UsersDataDelegate {
    var usersData: UsersData?
    
    @IBOutlet weak var vTextFieldUsername: UITextField!
    @IBOutlet weak var vTextFieldPassword: UITextField!
    @IBOutlet weak var vTextFieldConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func register(_ sender: Any) {
        if (self.vTextFieldUsername.text == "" || self.vTextFieldPassword.text == "" || self.vTextFieldConfirmPassword.text == "") {
            self.showIncorrectRegistrationError(withMessage: "All fields are required")
            return
        }
        
        if (self.vTextFieldPassword.text != self.vTextFieldConfirmPassword.text) {
            self.showIncorrectRegistrationError(withMessage: "Passwords do not match")
            return
        }
        
        let userToRegister = User(withUsername: self.vTextFieldUsername.text!, andPassword: self.vTextFieldPassword.text!)
        self.showLoading()
        self.usersData?.register(user: userToRegister)
    }
    
    func didRegistered(user: User) {
        let weakSelf = self
        DispatchQueue.main.async {
            weakSelf.hideLoading()
            weakSelf.showInformDialog(withTitle: "User registered", andMessage: "User successfully added", andHandler: { action in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginScreen")
                self.present(loginVC, animated: true, completion: nil)
            })
        }
    }
    
    func showIncorrectRegistrationError(withMessage errorMessage: String) {
        self.showInformDialog(withTitle: "Invalid input", andMessage: errorMessage, andHandler: { action in })
    }
}
