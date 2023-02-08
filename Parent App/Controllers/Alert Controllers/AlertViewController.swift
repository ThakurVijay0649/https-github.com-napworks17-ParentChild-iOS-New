//
//  AlertViewController.swift
//  Parent App
//
//  Created by Nap Works on 26/01/23.
//

import UIKit
import SVProgressHUD

protocol AlertDelegate {
    func getData(title: UILabel, message: UILabel)
}

class AlertViewController: CommonViewController {
    
    @IBOutlet weak var alertView: UIView!

    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertTitle: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var alertMessage: UILabel!
    
    var delegate: AlertDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.layer.cornerRadius = 10
        alertImage.layer.cornerRadius = alertImage.frame.size.width/2.0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        delegate?.getData(title: alertTitle, message: alertMessage)
        buttonRadius(button: okButton)
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton){
       
            let navigationController = UINavigationController(rootViewController: self.storyboard?.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController)
            navigationController.isNavigationBarHidden = true
            self.view.window?.rootViewController = navigationController
        
    }

}
