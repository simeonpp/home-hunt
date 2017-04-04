import Foundation
import UIKit
import CoreData

var loading = UIActivityIndicatorView()

extension UIViewController {
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    // Core data
    var managedObjectContext: NSManagedObjectContext {
        get {
            return self.appDelegate.persistentContainer.viewContext
        }
    }
    
    var apiAuthentication: ApiAuthentication? {
        get {
            do {
                let apiAuthentication = try self.managedObjectContext.fetch(ApiAuthentication.fetchRequest())
                if (apiAuthentication.count == 0) {
                    return nil
                } else {
                    return apiAuthentication.last as? ApiAuthentication
                }
            } catch let error as NSError {
                print("\(error.userInfo)")
                return nil
            }
            
        }
    }
    
    var cookie: String {
        get {
            let apiAuthentication = self.apiAuthentication
            if (apiAuthentication != nil) {
                let cookie = apiAuthentication?.cookie
                return cookie!
            } else {
                return ""
            }
        }
    }
    
    func deleteApiAuthenticationRecords() {
        do {
            let recordsToDelete = try
                self.managedObjectContext.fetch(ApiAuthentication.fetchRequest())
            for apiAuth in recordsToDelete {
                self.managedObjectContext.delete(apiAuth as! NSManagedObject)
            }
            self.appDelegate.saveContext()
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
    }
    
    // Handle bad cookie
    func handleApiRequestError(error: ApiError) {
        let weakSelf = self
        
        // Delete ApiAuthentication records in CoreData
        self.deleteApiAuthenticationRecords()
        
        // Show user notification to go to the login screen
        self.showInformDialog(withTitle: error.message, andMessage: "Please log in", andHandler: { action in
            weakSelf.redirectTologin()
        })
    }
    
    // Loading pop up
    func showLoading() {
        loading.frame = self.view.frame
        loading.activityIndicatorViewStyle = .whiteLarge
        loading.backgroundColor = UIColor(red: 0.95, green: 0.7, blue: 0.3, alpha: 0.7)
        self.view.addSubview(loading)
        loading.startAnimating()
    }
    
    func hideLoading() {
        loading.stopAnimating()
        loading.removeFromSuperview()
    }
    
    // Information pop up
    func showInformDialog(withTitle title: String, andMessage errorMessage: String, andHandler handler: @escaping ((UIAlertAction) -> Void)) -> Void {
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Redirect
    func redirectTologin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "loginScreen")
        self.present(loginVC, animated: false, completion: nil)
    }
}
