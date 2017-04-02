import UIKit

class RegisterViewController: UIViewController, UsersDataDelegate {
    @IBOutlet weak var vTextFieldUsername: UITextField!
    @IBOutlet weak var vTextFieldPassword: UITextField!
    @IBOutlet weak var vTextFieldConfirmPassword: UITextField!
    
    var usersData: UsersData?
    
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
        self.usersData?.register(user: userToRegister)
    }
    
    func didRegistered(user: User) {
        DispatchQueue.main.async {
            self.showIncorrectRegistrationError(withTitle: "User registered", andMessage: "User successfully added", andHandler: { action in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginScreen")
                self.present(loginVC, animated: true, completion: nil)
            })
        }
    }
    
    func showIncorrectRegistrationError(withMessage errorMessage: String) {
        self.showIncorrectRegistrationError(withTitle: "Invalid input", andMessage: errorMessage, andHandler: { action in })
    }
    
    func showIncorrectRegistrationError(withTitle title: String, andMessage errorMessage: String, andHandler handler: @escaping ((UIAlertAction) -> Void)) -> Void {
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
