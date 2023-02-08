//
//  LoginViewController.swift
//  Parent App
//
//  Created by Nap Works on 19/01/23.
//

import UIKit
import SVProgressHUD

class LoginViewController: CommonViewController {
    
    @IBOutlet weak var loginView: UIView!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backgroundImage()
        
        addIcon(iconName: "email", textfield: emailTextField)
        addIcon(iconName: "lock", textfield: passwordTextField)
        
        cornerRadius(view: loginView)
        
        textfieldRadius(textfield: emailTextField)
        textfieldRadius(textfield: passwordTextField)
        
        buttonRadius(button: loginButton)
        
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgotButtonPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        emailTextField.text = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        passwordTextField.text = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        if emailTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please enter email")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        } else if passwordTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please enter password")
            SVProgressHUD.dismiss(withDelay: 2)
        }
        else{
            SVProgressHUD.show(withStatus: "Loggin in")
            
            APICalling.login(email: emailTextField.text!, password: passwordTextField.text!) { success, message in
                if success {
                    SVProgressHUD.dismiss {
                        self.customAlert()
                    }
                }
                else {
                    SVProgressHUD.dismiss {
                        SVProgressHUD.showError(withStatus: message)
                        SVProgressHUD.dismiss(withDelay: 1.3)
                    }
                    
                }
            }
        }
        
    }
    

    //MARK: - getData func to get data for the custom alert
    override func getData(title: UILabel, message: UILabel) {
        title.text = "Yay! Login successfully"
        message.text = "You have login here successfully\n Lets do some fun"
    }
    
    @IBAction func goToSignUpButtonPressed(_ sender: Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotButtonPressed(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
