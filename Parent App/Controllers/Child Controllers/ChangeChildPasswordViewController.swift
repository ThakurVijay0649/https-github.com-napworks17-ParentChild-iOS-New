//
//  ChangeChildPasswordViewController.swift
//  Parent App
//
//  Created by Nap Works on 22/01/23.
//

import UIKit

class ChangeChildPasswordViewController: CommonViewController {
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldRadius(textfield: currentPasswordTextField)
        textfieldRadius(textfield: newPasswordTextField)
        textfieldRadius(textfield: confirmPasswordTextField)
        
        buttonRadius(button: submitButton)
        
        addIcon(iconName: "lock", textfield: currentPasswordTextField)
        addIcon(iconName: "lock", textfield: newPasswordTextField)
        addIcon(iconName: "lock", textfield: confirmPasswordTextField)
    }

    
    @IBAction func backButtonPressed(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton){
        
    }

}
