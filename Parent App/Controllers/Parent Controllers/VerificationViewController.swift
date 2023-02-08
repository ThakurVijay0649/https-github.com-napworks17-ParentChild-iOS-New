//
//  VerificationViewController.swift
//  Parent App
//
//  Created by Nap Works on 19/01/23.
//

import UIKit
class VerificationViewController: CommonViewController, UITextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        print(code)
    }
    
    var otpTextFields = [UITextField]()
    
    @IBOutlet weak var verificationView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage()
        cornerRadius(view: verificationView)
        
    }
    
    
    @IBAction func didTapSubmit(_ sender: UIButton){
       
    }
}
