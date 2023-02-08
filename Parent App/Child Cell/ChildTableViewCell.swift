//
//  ChildTableViewCell.swift
//  Parent App
//
//  Created by Nap Works on 22/01/23.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var childImage: UIImageView!
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var deleteImageView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var childName: UILabel!
    
    @IBOutlet weak var childAge: UILabel!
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.layer.cornerRadius = 10
        childImage.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        editImageView.layer.cornerRadius = editImageView.frame.size.width/2.0
        deleteImageView.layer.cornerRadius = deleteImageView.frame.size.width/2.0
        editImageView.clipsToBounds = true
        deleteImageView.clipsToBounds = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
    ///
    @IBAction func editButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.setValue(sender.tag, forKey: "childId")
    }
    
   
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.setValue(sender.tag, forKey: "childId")
    }
   
    
}
