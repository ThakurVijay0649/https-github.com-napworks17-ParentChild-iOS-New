//
//  SideNavigationViewController.swift
//  Parent App
//
//  Created by Nap Works on 27/01/23.
//

import UIKit
import Kingfisher

class SideMenuViewController: CommonViewController{
    
    @IBOutlet weak var userFullName: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    
    @IBOutlet var sideMenuView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
                return
            }

            // Use PropertyListDecoder to convert Data into Player
            guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
                return
            }
        userFullName.text = user.fullName
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2.0
        userImageView.clipsToBounds = true
       
        
        if user.loginType == "google"{
            guard let userGoogleImageData = defaults.value(forKey: "userGoogleImage") as? Data else {return}
            guard let userGoogleImage = try? PropertyListDecoder().decode( UserGoogleImage.self, from: userGoogleImageData) else {return}
            userImageView.kf.setImage(
                with: userGoogleImage.image!,
                placeholder: UIImage(named: "childplaceholder"),
                options: [
                    .transition(.fade(0.25)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    self.userImageView.image = value.image
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }else if user.loginType == "facebook"{
            guard let userFacebookImageData = defaults.value(forKey: "userFacebookImage") as? [String: AnyObject] else {return}
            let userFacebookImage = userFacebookImageData["data"]! as! [String: AnyObject]

            let userFacebookImageUrl = URL(string: userFacebookImage["url"] as! String)
            userImageView.kf.setImage(
                with: userFacebookImageUrl,
                placeholder: UIImage(named: "childplaceholder"),
                options: [
                    .transition(.fade(0.25)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    self.userImageView.image = value.image
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }else {
            let url = URL(string: "http://parentchild.in/public/images/men.png")
            userImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "childplaceholder"),
                options: [
                    .transition(.fade(0.25)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    self.userImageView.image = value.image
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    @IBAction func logoutbntPressed(_ sender: UIButton) {
        let alert = self.storyboard!.instantiateViewController(withIdentifier: "LogoutAlertViewController") as! LogoutAlertViewController
        alert.modalPresentationStyle = .overFullScreen
        alert.providesPresentationContextTransitionStyle = true
        alert.definesPresentationContext = true
        alert.modalTransitionStyle = .crossDissolve
        self.present(alert, animated: true, completion: nil)
    }
    
}
