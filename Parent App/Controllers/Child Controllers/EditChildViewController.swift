//
//  EditChildViewController.swift
//  Parent App
//
//  Created by Nap Works on 22/01/23.
//

import UIKit
import SVProgressHUD
import Kingfisher

class EditChildViewController: CommonViewController, UITextFieldDelegate {
    
    var userid: Int?
    var usersession: String?
    var userauth: String?
    var childid: Int?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var childImage: UIImageView!
    
    @IBOutlet weak var childCode: UILabel!
    
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var gradeTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var changePasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
        textfieldRadius(textfield: nameTextField)
        textfieldRadius(textfield: phoneTextField)
        textfieldRadius(textfield: dateTextField)
        textfieldRadius(textfield: gradeTextField)
        buttonRadius(button: submitButton)
        buttonRadius(button: changePasswordButton)
        childImage.layer.cornerRadius = 10
        
        addIcon(iconName: "user", textfield: nameTextField)
        addIcon(iconName: "phone", textfield: phoneTextField)
        addIcon(iconName: "date", textfield: dateTextField)
        addIcon(iconName: "grade", textfield: gradeTextField)
        
        buttonOutline(button: changePasswordButton, color: "#38369A")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditChildViewController.didTapAddChildImage))
        childImage.addGestureRecognizer(tap)
        childImage.isUserInteractionEnabled = true
        
        let defaults = UserDefaults.standard
        let childId = defaults.value(forKey: "childId")
        childid = childId as? Int
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
            return
        }
        
        /// Use PropertyListDecoder to convert Data into user
        guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
            return
        }
        userid = user.id
        usersession = user.session
        userauth = user.auth
        
        ///GetChildProfile API calling to get the profile data of individual child using childid
        APICalling.getChildProfile(childId: childId as! Int, session: usersession!, auth: userauth!) { [self] success, childprofile in
            if success {
                self.childCode.text = childprofile?.user_name
                self.nameTextField.text = childprofile?.full_name
                self.dateTextField.text = childprofile?.date_of_birth
                self.gradeTextField.text = childprofile?.grade
                let url = URL(string: (childprofile?.image!)!)
                self.childImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "childplaceholder"),
                    options: [
                        .transition(.fade(0.25)),
                        .cacheOriginalImage
                    ])
                { [self]
                    result in
                    switch result {
                    case .success(let value):
                        childImage.image = value.image
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
                
            }
        }
        
        /// GetChildList API calling to get the information of individual child using childid
        APICalling.getChildList(userId: userid!, session: usersession!, auth: userauth!) { success, childList in
            if success {
                for child in childList! {
                    if child.childId == childId as? Int {
                        self.phoneTextField.text = child.phoneNumber
                    }
                }
            }
        }
        
    }
    
    
    @objc private func didTapAddChildImage(){
        presentPhotoActionSheet()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.tintColor = UIColor.clear
        self.openDatePicker(textField: dateTextField)
    }
    
    override func cancelButtonClicked() {
        dateTextField.resignFirstResponder()
    }
    
    override func doneButtonClicked() {
        if let datePicker = dateTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        dateTextField.resignFirstResponder()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        // shows progress loading here
        SVProgressHUD.show(withStatus: "Updating...")
        var model = ChildPostData()
        model.fullName = nameTextField.text!
        model.dateOfBirth = dateTextField.text!
        model.grade = gradeTextField.text!
        //MARK: - Add Child API called here
        APICalling.uploadImage(image: childImage.image!) { success, url in
            if success {
                APICalling.updateChild(model: model, childimage: url!,phoneNumber: self.phoneTextField.text!, userId: self.userid!, childId: self.childid!, session: self.usersession!, auth: self.userauth!) {
                    success in
                    if success {
                        SVProgressHUD.dismiss() {
                            self.navigationController?.popViewController(animated: true)
                        }
            
                    }
                    else {
                        SVProgressHUD.dismiss {
                            self.showAlert(title: Constants.APP_NAME, message: "Failed to update child data", handler: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeChildPasswordViewController") as! ChangeChildPasswordViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension EditChildViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    /// Method to present the action sheet of choosing method of selecting profile picture of child
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: Constants.APP_NAME,
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Camera",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
        
    }
    
    /// Method to present the camera of device when user taps on camera option
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    /// Method to present the gallery of device when user taps on gallery option
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    /// Method when user selects an image from gallery
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else { return }

                childImage.image = image
                dismiss(animated: true, completion: nil)

    }
    
    /// Method when user taps on cancel button
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
