//
//  ForgotPasswordViewController.swift
//  Parent App
//
//  Created by Nap Works on 19/01/23.
//

import UIKit

class ForgotPasswordViewController: CommonViewController {
    
    @IBOutlet weak var forgotPasswordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var verificationCodeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage()
        
        addIcon(iconName: "email", textfield: emailTextField)
        
        cornerRadius(view: forgotPasswordView)
        textfieldRadius(textfield: emailTextField)
        
        buttonRadius(button: verificationCodeButton)
    }
   
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func verificationCodeButtonPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerificationViewController") as! VerificationViewController
        if !emailTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Parent App", message: "OTP has been sent to your email successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.navigationController?.pushViewController(vc, animated: true)
            }))
        present(alert, animated: true)
        }
        else {
//            showAlert(title: "Parent App", message: "Please enter email to get the otp!")
        }
     
    }
}
