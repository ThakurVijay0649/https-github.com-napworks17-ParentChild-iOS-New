//
//  AccountViewController.swift
//  Parent App
//
//  Created by Nap Works on 17/01/23.
//

import UIKit
import GoogleSignIn
import SVProgressHUD
import FBSDKLoginKit

class AccountViewController: CommonViewController {
    
    @IBOutlet weak var accountView: UIView!
    
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var googleButton: UIButton!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    var accountType: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let token = AccessToken.current, !token.isExpired {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format, age_range"], tokenString: token.tokenString, version: nil, httpMethod: .get).start(completion: { (connection, result, error) -> Void in
                if let result = result, error == nil {
                    let userData = result as! [String: AnyObject]
                    print(userData["name"]!)
                    print(userData["id"]!)
                    print(userData["email"]!)
                }
                
            })
        }
        
        cornerRadius(view: accountView)
        
        buttonCornerRadius(button: facebookButton)
        buttonCornerRadius(button: googleButton)
        buttonCornerRadius(button: createAccountButton)
        
        buttonOutline(button: createAccountButton, color: "#ffffff")
        
        CommonMethods.showLog("AccountViewcontroller", accountType)
      
    }
    
    private func buttonCornerRadius(button: UIButton){
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    
    
    
    @IBAction func goToSignUpViewController(_ sender: Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        vc.accounttype = accountType
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToLoginViewController(_ sender: Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func facebookButtonPressed(_ sender: UIButton) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    if((AccessToken.current) != nil){
                        GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format, age_range"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: .get).start(completion: { (connection, result, error) -> Void in
                            if let result = result, error == nil {
                                let userData = result as! [String: AnyObject]
                                
                                if let image = userData["picture"] {
                                    UserDefaults.standard.setValue(image, forKey: "userFacebookImage")
                                }
                                
                                
                                
                                if let email = userData["email"],
                                   let facebookID = userData["id"],
                                   let fullName = userData["name"]{
                                    SVProgressHUD.show(withStatus: "Loggin in")
                                    APICalling.loginWithFacebook(email: email as! String, fullName: fullName as! String, facebookId: facebookID as! String) { success, message in
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
                        })
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func googleButtonPressed(_ sender: UIButton) {
        //499333115944-vuqbuuk2a146u1n2bv7m2do3jjs1j13p.apps.googleusercontent.com
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { AuthResult, error in
            guard let result = AuthResult else {return}
            let user = result.user
            let email = user.profile?.email
            let name = user.profile?.name
            let image = user.profile?.imageURL(withDimension: 100)
            var userGoogleImage = UserGoogleImage()
            userGoogleImage.image = image
            //MARK: - Save user's google image into userdefaults using property list encoder
            UserDefaults.standard.set(try? PropertyListEncoder().encode(userGoogleImage), forKey: "userGoogleImage")
            
            print("user details: \(user.userID!)\n \(email!)\n \(name!)")
            SVProgressHUD.show(withStatus: "Loggin in")
            APICalling.loginWithGoogle(email: email!, fullName: name!, googleId: user.userID!) { success, message in
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
}

struct UserGoogleImage: Codable {
    var image: URL?
}

