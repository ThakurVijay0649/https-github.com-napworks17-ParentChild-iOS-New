//
//  DeleteChildAlertViewController.swift
//  Parent App
//
//  Created by Nap Works on 02/02/23.
//

import UIKit
import SVProgressHUD

class DeleteChildAlertViewController: UIViewController {
    
    
    @IBOutlet weak var deleteChildAlertView: UIView!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var userid: Int?
    var usersession: String?
    var userauth: String?
    var childid: Int?
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteChildAlertView.layer.cornerRadius = 10
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        let defaults = UserDefaults.standard
        let childId = defaults.value(forKey: "childId")
        
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
            return
        }
        
        /// Use PropertyListDecoder to convert Data into user
        guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
            return
        }
        userid = user.id
        usersession = user.session
        userauth = user.auth
        childid = childId as? Int
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        APICalling.deleteChild(userId: userid!, session: usersession!, auth: userauth!, childId: childid!) { success in
            if success {
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "Child Deleted Successfully")
                SVProgressHUD.dismiss(withDelay: 1.1)
                
                let navigationController = UINavigationController(rootViewController: self.storyboard?.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController)
            
                navigationController.isNavigationBarHidden = true
                self.view.window?.rootViewController = navigationController
            }
        }
    }
    
}
