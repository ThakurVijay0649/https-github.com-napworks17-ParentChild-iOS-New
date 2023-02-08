//
//  AddChildViewController.swift
//  Parent App
//
//  Created by Nap Works on 21/01/23.
//

import UIKit
import SVProgressHUD

class AddChildViewController: CommonViewController, UITextFieldDelegate {


    
    @IBOutlet weak var addChildView: UIView!
    
    @IBOutlet weak var childImage: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    @IBOutlet weak var gradeTextField: UITextField!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    var userId: Int?
    var session: String?
    var auth: String?
    var imageString: String!
    let addImage = UIImage(named: "addchildicon")

    override func viewDidLoad() {
        super.viewDidLoad()
        dateOfBirthTextField.delegate = self
        buttonRadius(button: submitButton)
        textfieldRadius(textfield: nameTextField)
        textfieldRadius(textfield: phoneNumberTextField)
        textfieldRadius(textfield: dateOfBirthTextField)
        textfieldRadius(textfield: gradeTextField)
        addIcon(iconName: "user", textfield: nameTextField)
        addIcon(iconName: "phone", textfield: phoneNumberTextField)
        addIcon(iconName: "date", textfield: dateOfBirthTextField)
        addIcon(iconName: "grade", textfield: gradeTextField)
        self.hideKeyboardTappedAround()
        
        childImage.image = addImage
        
        // add action on image click
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChildViewController.didTapAddChildImage))
        childImage.addGestureRecognizer(tap)
        childImage.isUserInteractionEnabled = true
        
        
        //fetch the user from userdefaults
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
            return
        }
        
        // Use PropertyListDecoder to convert Data into Player
        guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
            return
        }
        userId = user.id
        session = user.session
        auth = user.auth
        
    }
    
    @objc private func didTapAddChildImage(){
        presentPhotoActionSheet()
    }
    
    @IBAction func backButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        //MARK: - Removing Whitespace from begining and end of TextFields
        nameTextField.text = nameTextField.text?.trimmingCharacters(in: .whitespaces)
        phoneNumberTextField.text = phoneNumberTextField.text?.trimmingCharacters(in: .whitespaces)
        dateOfBirthTextField.text = dateOfBirthTextField.text?.trimmingCharacters(in: .whitespaces)
        gradeTextField.text = gradeTextField.text?.trimmingCharacters(in: .whitespaces)
        //MARK: - TextField Validations
        if childImage.image == addImage {
            SVProgressHUD.showError(withStatus: "Please Select Profile Photo")
            SVProgressHUD.dismiss(withDelay: 1.5)
        }
        else if nameTextField.text == ""{
            SVProgressHUD.showError(withStatus: "Please Enter Name")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        }else if phoneNumberTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Email")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        } else if dateOfBirthTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Password")
            SVProgressHUD.dismiss(withDelay: 1.5)
            
        } else if gradeTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Please Enter Confirm")
            SVProgressHUD.dismiss(withDelay: 1.5)
        }
        else{
            // shows progress loading here
            SVProgressHUD.show(withStatus: "Adding child")
            var model = ChildPostData()
            model.fullName = nameTextField.text!
            model.dateOfBirth = dateOfBirthTextField.text!
            model.grade = gradeTextField.text!
        
            //MARK: - Add Child API called here
            APICalling.uploadImage(image: childImage.image!) { success, url in
                if success {
                    APICalling.addChild(model: model, childimage: url!,phoneNumber: self.phoneNumberTextField.text!, userId: self.userId!, session: self.session!, auth: self.auth!) {
                        success, code, password  in
                        if success {
                            SVProgressHUD.dismiss {
                                let alert =  self.storyboard?.instantiateViewController(withIdentifier: "ChildAddedAlertViewController") as! ChildAddedAlertViewController
                                alert.code = code!
                                alert.password = password!
                                alert.modalPresentationStyle = .overCurrentContext
                                alert.providesPresentationContextTransitionStyle = true
                                alert.definesPresentationContext = true
                                alert.modalTransitionStyle = .crossDissolve
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else {
                            SVProgressHUD.dismiss {
                                self.showAlert(title: Constants.APP_NAME, message: "Failed to add child data", handler: nil)
                            }
                            
                        }
                    }
                }
            }
     
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.tintColor = UIColor.clear
        self.openDatePicker(textField: dateOfBirthTextField)
    }
    
    override func cancelButtonClicked() {
        dateOfBirthTextField.resignFirstResponder()
    }
    
    override func doneButtonClicked() {
        if let datePicker = dateOfBirthTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
        }
        dateOfBirthTextField.resignFirstResponder()
    }
}

//MARK: - Image Picker Controller Methods
extension AddChildViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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


extension AddChildViewController {
    
}

extension UIViewController {
    func hideKeyboardTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
