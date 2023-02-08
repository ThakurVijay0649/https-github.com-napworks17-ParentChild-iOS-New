//
//  ChildHomeViewController.swift
//  Parent App
//
//  Created by Nap Works on 07/02/23.
//

import UIKit
import Kingfisher

class ChildHomeViewController: CommonViewController {

    
    @IBOutlet weak var childHomeView: UIView!
    
    @IBOutlet weak var childName: UILabel!
    
    @IBOutlet weak var childImageView: UIImageView!
    
    @IBOutlet weak var childMessageView: UIView!
    
    @IBOutlet weak var childMessage: UILabel!
    
    @IBOutlet weak var childHomeDoneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadius(view: childHomeView)
        childImageView.layer.cornerRadius = childImageView.frame.size.width / 2
        childImageView.layer.borderWidth = 0.5
        childImageView.layer.borderColor = UIColor.gray.cgColor
        childMessageView.layer.cornerRadius = 10
        buttonRadius(button: childHomeDoneButton)
        let defaults = UserDefaults.standard
        guard let childData = defaults.object(forKey: Constants.CHILD_KEY) as? Data else {
                return
            }

            guard let child = try? PropertyListDecoder().decode(ChildLoginData.self, from: childData) else {
                return
            }
        childName.text = "Hello \(child.fullName!), Welcome"
        childMessage.text = "You have connected with this parent( \(child.parentName!)). we will send question shortly"
        let url = URL(string: child.image!)
      
        childImageView.kf.setImage(
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
                self.childImageView.image = value.image
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func childHomeDoneButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Parent App", message: "Are you sure you want to quit?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { _ in
            exit(0)
        }))
        
        present(alert, animated: true)
    }
    
}
