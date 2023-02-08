//
//  CommonViewController.swift
//  Parent App
//
//  Created by Nap Works on 19/01/23.
//

import UIKit

class CommonViewController: UIViewController, AlertDelegate {
    func getData(title: UILabel, message: UILabel) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    ///Method defined in CommonViewController that helps to add an Icon in left view of any textfield
    public func addIcon(iconName: String, textfield: UITextField){
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: iconName)
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 5, y: 0, width: UIImage(named: iconName)!.size.width+25 , height: UIImage(named: iconName)!.size.height)
        
        imageIcon.frame = CGRect(x: 20, y: 0, width: UIImage(named: iconName)!.size.width, height: UIImage(named: iconName)!.size.height)
        
        textfield.leftView = contentView
        textfield.leftViewMode = .always
    }
    
    ///Method defined in CommonViewController that helps to add corner radius around any uiview
    public func cornerRadius(view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    ///Method defined in CommonViewController that helps to add background image on background of uiview
    public func backgroundImage(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    ///Method defined in CommonViewController that helps to add corner radius around any textfield
    public func textfieldRadius(textfield: UITextField){
        textfield.layer.cornerRadius = 15
        textfield.clipsToBounds = true
    }
    
    ///Method defined in CommonViewController that helps to add corner radius around any uibutton
    public func buttonRadius(button: UIButton){
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    ///Method defined in CommonViewController that helps to show an alert
    public func showAlert(title: String, message: String,handler: ((UIAlertAction)->Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        
        present(alert, animated: true)
    }
    
    ///Method defined in CommonViewController that helps to convert hex color to uicolor
    public func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    ///Method defined in CommonViewController that helps to create stroke of any color around any uibutton
    public func buttonOutline(button: UIButton, color: String){
        button.layer.borderWidth = 2
        button.layer.borderColor = hexStringToUIColor(hex: color).cgColor
    }
    
    
    //MARK: - Custom Alert Controller Method
    public func customAlert(){
        let alert = self.storyboard?.instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        alert.delegate = self
        alert.modalPresentationStyle = .overCurrentContext
        alert.providesPresentationContextTransitionStyle = true
        alert.definesPresentationContext = true
        alert.modalTransitionStyle = .crossDissolve
        self.present(alert, animated: true, completion: nil)
    }
        
    public func openDatePicker(textField: UITextField){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        textField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
        
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelButton, flexibleButton, doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        
    }
    
    @objc func cancelButtonClicked(){
    }
    
    @objc func doneButtonClicked(){

    }
    
    
}
