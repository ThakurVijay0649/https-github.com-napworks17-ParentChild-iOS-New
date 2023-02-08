//
//  HomeTableViewController.swift
//  Parent App
//
//  Created by Nap Works on 21/01/23.
//

import UIKit
import SVProgressHUD
import Kingfisher

class HomeTableViewController: CommonViewController, UITableViewDelegate, UITableViewDataSource{
    var phoneNumber: String?
    var childArray : [ChildListData] = []
    
    @IBOutlet weak var parentName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var childview: UIView!
    
    @IBOutlet weak var addChildButton: UIButton!
    
    /// date formatter to calculate age of child
    lazy var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        backgroundImage()
        tableView.delegate = self
        tableView.dataSource = self
        cornerRadius(view: childview)
         buttonRadius(button: addChildButton)
        tableView.register(UINib(nibName: "ChildTableViewCell", bundle: nil), forCellReuseIdentifier: "childcell")
       
        ///fetch parent data from userdefaults
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
            return
        }
        
        /// Use PropertyListDecoder to convert Data into user
        guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
            return
        }
        ///title on home view
        parentName.text = "Welcome, \(user.fullName!)👍"
        
        ///API calling to get child list
        SVProgressHUD.show()
        APICalling.getChildList(userId: user.id!, session: user.session!, auth: user.auth!) { success, childList in
            if success {
                self.childArray = childList!
                self.tableView.reloadData()
            }
        }
        SVProgressHUD.dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: Constants.USER_KEY) as? Data else {
            return
        }
        
        /// Use PropertyListDecoder to convert Data into user
        guard let user = try? PropertyListDecoder().decode(UserData.self, from: userData) else {
            return
        }
        ///API calling to get child list
        SVProgressHUD.show()
        APICalling.getChildList(userId: user.id!, session: user.session!, auth: user.auth!) { success, childList in
            if success {
                self.childArray = childList!
                self.tableView.reloadData()
            }
        }
        SVProgressHUD.dismiss()
    }
    
    // MARK: - Table view data source
    ///Number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childArray.count
    }
    
    ///Cell for tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "childcell") as! ChildTableViewCell
        cell.editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        cell.childName.text = childArray[indexPath.row].fullName
        cell.deleteButton.tag = childArray[indexPath.row].childId!
        cell.editButton.tag = childArray[indexPath.row].childId!
        phoneNumber = "1234"
        let url = URL(string: childArray[indexPath.row].image!)
      
        cell.childImage.kf.setImage(
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
                cell.childImage.image = value.image
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }

        
        let birthday = dateFormatter.date(from: childArray[indexPath.row].dateOfBirth!)
        let timeInterval = birthday?.timeIntervalSinceNow
        let age = abs(Int(timeInterval! / 31556926.0))
        
        cell.childAge.text = "Age: \(age)"
        return cell
    }

    ///Method to go to edit view controller
    @objc private func didTapEditButton(){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editChildVC = self.storyboard!.instantiateViewController(withIdentifier: "EditChildViewController") as! EditChildViewController

        navigationController?.pushViewController(editChildVC, animated: true)
        
    }
    
    ///Method to delete the child from the list
    @objc private func didTapDeleteButton(){
        let alert = self.storyboard!.instantiateViewController(withIdentifier: "DeleteChildAlertViewController") as! DeleteChildAlertViewController
       
        alert.modalPresentationStyle = .overFullScreen
        alert.providesPresentationContextTransitionStyle = true
        alert.definesPresentationContext = true
        alert.modalTransitionStyle = .crossDissolve
        self.present(alert, animated: true, completion: nil)
    }
    
    
    ///Method to go to add child view controller
    @IBAction func addChildButtonPressed(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddChildViewController") as! AddChildViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
