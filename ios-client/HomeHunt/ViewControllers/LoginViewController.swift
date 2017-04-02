import UIKit
import CoreData

class LoginViewController: UIViewController, UsersDataDelegate {
    var usersData: UsersData?
    
    @IBOutlet weak var vTextFieldUsername: UITextField!
    @IBOutlet weak var vTextFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("------")
        print(self.cookie)
        if (self.cookie != "") {
            self.redirectToHome()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: UIButton) {
        let username = self.vTextFieldUsername.text
        let password = self.vTextFieldPassword.text
        
        if (username == "" || password == "") {
            self.showIncorrectRegistrationError(withMessage: "All fields are required")
            return
        }
        
        let userToLogin = User(withUsername: username!, andPassword: password!)
        self.showLoading()
        self.usersData?.login(user: userToLogin)
    }
    
    func showIncorrectRegistrationError(withMessage errorMessage: String) {
        self.showInformDialog(withTitle: "Invalid input", andMessage: errorMessage, andHandler: { action in })
    }
    
    func didLogin(cookie: String, error: String?) {
        let weakSelf = self
        
        DispatchQueue.main.async {
            if (error == nil) {
                // Store to CoreData
                let entity = NSEntityDescription.entity(forEntityName: "ApiAuthentication", in: self.managedObjectContext)
                let apiAuthentication: ApiAuthentication = ApiAuthentication(entity: entity!, insertInto: self.managedObjectContext)
                apiAuthentication.cookie = cookie
                
                self.managedObjectContext.insert(apiAuthentication)
                self.appDelegate.saveContext()
                
                // Redirect to home screen
                weakSelf.redirectToHome()
                
                weakSelf.hideLoading()
            } else {
                weakSelf.hideLoading()
                weakSelf.showInformDialog(withTitle: "Invalid credentials", andMessage: "Please make sure your usename or/and password is correct", andHandler: { action in })
            }
        }
    }
    
    func redirectToHome() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "homeNavigation")
        self.present(homeVC, animated: false, completion: nil)
        //        self.navigationController!.pushViewController(homeVC, animated: true)
    }
}
