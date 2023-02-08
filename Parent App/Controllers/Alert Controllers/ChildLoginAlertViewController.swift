//
//  ChildLoginAlertViewController.swift
//  Parent App
//
//  Created by Nap Works on 07/02/23.
//

import UIKit

class ChildLoginAlertViewController: CommonViewController {

    
    @IBOutlet weak var childLoginAlertView: UIView!
    
    @IBOutlet weak var childCheckmark: UIImageView!
    
    @IBOutlet weak var childLoginOkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childLoginAlertView.layer.cornerRadius = 10
        childCheckmark.layer.cornerRadius = childCheckmark.frame.size.width/2.0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        buttonRadius(button: childLoginOkButton)
    }
    
    @IBAction func childLoginOkButtonPressed(_ sender: Any) {
        let navigationController = UINavigationController(rootViewController: self.storyboard?.instantiateViewController(withIdentifier: "ChildHomeViewController") as! ChildHomeViewController)
        navigationController.isNavigationBarHidden = true
        self.view.window?.rootViewController = navigationController
    }
    
}
