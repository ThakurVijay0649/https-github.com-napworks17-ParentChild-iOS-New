//
//  ChildLoginViewController.swift
//  Parent App
//
//  Created by Nap Works on 07/02/23.
//

import UIKit
import SVProgressHUD

class ChildLoginViewController: CommonViewController {
    var accountType: String = ""
    
    @IBOutlet weak var childLoginView: UIView!
    
    @IBOutlet weak var childCodeTextField: UITextField!
    
    @IBOutlet weak var childPasswordTextField: UITextField!
    
    @IBOutlet weak var childLoginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRadius(button: childLoginButton)
        buttonOutline(button: childLoginButton, color: "#ffffff")
        textfieldRadius(textfield: childCodeTextField)
        textfieldRadius(textfield: childPasswordTextField)
        addIcon(iconName: "email", textfield: childCodeTextField)
        addIcon(iconName: "lock", textfield: childPasswordTextField)
        cornerRadius(view: childLoginView)
    }
 
    @IBAction func childLoginButtonPressed(_ sender: UIButton) {
        //MARK: - Removing Whitespace from begining and end of TextFields
        childCodeTextField.text = childCodeTextField.text?.trimmingCharacters(in: .whitespaces)
        childPasswordTextField.text = childPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
    
        //MARK: - TextField Validations
    if childCodeTextField.text == ""{
            SVProgressHUD.showError(withStatus: "Please Enter Name")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        }else if childPasswordTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Email")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        }
        else{
            // shows progress loading here
            SVProgressHUD.show(withStatus: "Loggin in...")
        
            //MARK: - Add Child API called here
            APICalling.loginChild(childCode: childCodeTextField.text!, childPassword: childPasswordTextField.text!) {
                success, message  in
                if success {
                    SVProgressHUD.dismiss {
                        let alert =  self.storyboard?.instantiateViewController(withIdentifier: "ChildLoginAlertViewController") as! ChildLoginAlertViewController
                        alert.modalPresentationStyle = .overCurrentContext
                        alert.providesPresentationContextTransitionStyle = true
                        alert.definesPresentationContext = true
                        alert.modalTransitionStyle = .crossDissolve
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else {
                    SVProgressHUD.dismiss {
                        self.showAlert(title: Constants.APP_NAME, message: "Failed to login child", handler: nil)
                    }
                    
                }
            }
            
        }
    }
    }
    

