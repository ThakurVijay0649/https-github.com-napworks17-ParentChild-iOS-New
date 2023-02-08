//
//  ViewController.swift
//  Parent App
//
//  Created by Nap Works on 16/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tutorImageView: UIImageView!
    
    @IBOutlet weak var parentImageView: UIImageView!
    
    @IBOutlet weak var childImageView: UIImageView!

    
    @IBOutlet weak var tutorButton: UIButton!
    
    @IBOutlet weak var parentButton: UIButton!
    @IBOutlet weak var childButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let buttonArray: [UIButton] = [tutorButton, parentButton, childButton]
        let imageArray: [UIImageView] = [tutorImageView, parentImageView, childImageView]
        
        for button in buttonArray {
            buttonShadowAndCornerRadius(button: button)
        }
        
        for image in imageArray {
            image.layer.cornerRadius = image.frame.size.width/2
        }

    }
    
    private func buttonShadowAndCornerRadius(button: UIButton){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = .zero
        button.layer.cornerRadius = 30
    }
    
    private func goToAccountViewController(account: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        vc.accountType = account
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func parentButtonPressed(_ sender: Any) {
        goToAccountViewController(account: "parent")
    }
    
    @IBAction func childButtonPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChildLoginViewController") as! ChildLoginViewController
        vc.accountType = "child"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tutorButtonPressed(_ sender: Any) {
        goToAccountViewController(account: "tutor")
    }
    
}

