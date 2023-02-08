//
//  ChildAddedAlertViewController.swift
//  Parent App
//
//  Created by Nap Works on 01/02/23.
//

import UIKit

class ChildAddedAlertViewController: CommonViewController {

    var code = ""
    var password = ""
    @IBOutlet weak var childAlertView: UIView!
    @IBOutlet weak var childCode: UILabel!

    @IBOutlet weak var childAlertImage: UIImageView!
    
    @IBOutlet weak var childPassword: UILabel!
    
    @IBOutlet weak var childOkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        childAlertView.layer.cornerRadius = 10
        childAlertImage.layer.cornerRadius = childAlertImage.frame.size.width/2.0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        buttonRadius(button: childOkButton)
    
        childCode.text = code
        childPassword.text = password
    }

    @IBAction func childOkButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            
            let navigationController = UINavigationController(rootViewController: self.storyboard?.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController)
        
            navigationController.isNavigationBarHidden = true
            self.view.window?.rootViewController = navigationController
        }
    }
}
