//
//  ChangePasswordViewController.swift
//  Parent App
//
//  Created by Nap Works on 19/01/23.
//

import UIKit

class ChangePasswordViewController:CommonViewController{
    
    @IBOutlet weak var changePasswordView: UIView!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        cornerRadius(view: changePasswordView)
        addIcon(iconName: "lock", textfield: newPasswordTextField)
        addIcon(iconName: "lock", textfield: confirmNewPasswordTextField)
        
        textfieldRadius(textfield: newPasswordTextField)
        textfieldRadius(textfield: confirmNewPasswordTextField)
        
        submitButton.layer.cornerRadius = 15
        submitButton.clipsToBounds = true
    }

    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if newPasswordTextField.text!.isEmpty {
//            showAlert(title: "Parent App", message: "Please enter new password!")
        }
        else if confirmNewPasswordTextField.text!.isEmpty {
//            showAlert(title: "Parent App", message: "Please confirm new password!")
        }
        else if newPasswordTextField.text! != confirmNewPasswordTextField.text! {
//            showAlert(title: "Parent App", message: "Password doesn't matched!")
        }
        else {
//            showAlert(title: "Parent App", message: "Password changed successfully!")
        }
    }
    
    @IBAction func backButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    

}
