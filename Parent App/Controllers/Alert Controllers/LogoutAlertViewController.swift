//
//  LogoutAlertViewController.swift
//  Parent App
//
//  Created by Nap Works on 27/01/23.
//

import UIKit
import SVProgressHUD
import FBSDKLoginKit
import GoogleSignIn

class LogoutAlertViewController: UIViewController {
    
    @IBOutlet weak var logoutAlertView: UIView!
    
    var theuser = UserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutAlertView.layer.cornerRadius = 10
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
                return
            }

            // Use PropertyListDecoder to convert Data into Player
            guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
                return
            }
        theuser = user
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            let logout = LoginManager()
            logout.logOut()
            GIDSignIn.sharedInstance.signOut()
            Auth.shared.removeUser()
            Auth.shared.removeChild()
            Auth.shared.removeAccountType()
            UINavigationController().popToRootViewController(animated: true)
            let navigationController = UINavigationController(rootViewController: self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
            navigationController.isNavigationBarHidden = true
           
            self.view.window?.rootViewController = navigationController
            SVProgressHUD.showSuccess(withStatus: "Logged out successfully")
            SVProgressHUD.dismiss(withDelay: 1.2)
        }
    }
    
}
