//
//  SignupViewController.swift
//  Parent App
//
//  Created by Nap Works on 17/01/23.
//

import UIKit
import SVProgressHUD

class SignupViewController: CommonViewController {

    
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    var accounttype: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage()
        // Do any additional setup after loading the view.
        addIcon(iconName: "user", textfield: nameTextField)
        addIcon(iconName: "email", textfield: emailTextField)
        addIcon(iconName: "lock", textfield: passwordTextField)
        addIcon(iconName: "lock", textfield: confirmPasswordTextField)
        
        cornerRadius(view: signupView)
        
        textfieldRadius(textfield: nameTextField)
        textfieldRadius(textfield: emailTextField)
        textfieldRadius(textfield: passwordTextField)
        textfieldRadius(textfield: confirmPasswordTextField)
        
        buttonRadius(button: signupButton)
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Sign up here---
    @IBAction func signupButtonPressed(){
        //removing whitespaces in the textfields
        nameTextField.text = nameTextField.text?.trimmingCharacters(in: .whitespaces)
        emailTextField.text = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        passwordTextField.text = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        confirmPasswordTextField.text = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespaces)
        
        if nameTextField.text == ""{
            SVProgressHUD.showError(withStatus: "Please Enter Name")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        }else if emailTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Email")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        } else if passwordTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Password")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        } else if confirmPasswordTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Confirm")
            SVProgressHUD.dismiss(withDelay: 1.5)
        }else if passwordTextField.text != confirmPasswordTextField.text {
            SVProgressHUD.showError(withStatus: "Password do not match")
            SVProgressHUD.dismiss(withDelay: 1.5)
        }
        else{
            // shows progress loading here
            SVProgressHUD.show(withStatus: "Signing up")
            var model = UserData()
            model.fullName = nameTextField.text!
            model.email = emailTextField.text!
            model.deviceType = Constants.DEVICE_TYPE
            model.accountType = accounttype!
            
            //signup api calling method
            APICalling.register(model: model, password: passwordTextField.text!) {
                success,message  in
                if success {
                    SVProgressHUD.dismiss {
                        self.customAlert()
                    }
                }
                else {
                    SVProgressHUD.dismiss {
                        self.showAlert(title: Constants.APP_NAME, message: message, handler: nil)
                    }
                    
                }
            }
            
        }
        
    }
    
    override func getData(title: UILabel, message: UILabel) {
        title.text = "Account created successfully"
        message.text = "You have created your account successfully"
    }
    
    
    //MARK: - Forgot password button here---
    @IBAction func forgotButtonPressed(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//    let parameters: [String: Any]
//    let parameters: [String: Any] = [
//        "IdQuiz" : 102,
//        "IdUser" : "iosclient",
//        "User" : "iosclient",
//        "List": [
//            [
//                "IdQuestion" : 5,
//                "IdProposition": 2,
//                "Time" : 32
//            ],
//            [
//                "IdQuestion" : 4,
//                "IdProposition": 3,
//                "Time" : 9
//            ]
//        ]
//    ]
//
//    Alamofire.request("http://myserver.com", method: .post, parameters: parameters, encoding: JSONEncoding.default)
//        .responseJSON { response in
//            print


//validations of textfields
//        if !nameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//            // string contains non-whitespace characters
//        }
