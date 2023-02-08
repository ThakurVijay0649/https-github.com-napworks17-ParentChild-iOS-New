//
//  Child.swift
//  Parent App
//
//  Created by Nap Works on 31/01/23.
//

import Foundation

struct AddChildModel : Codable {
    let status : Int?
    let message : String?
    let userData : ChildPostData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case userData = "userData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(ChildPostData.self, forKey: .userData)
    }

}

struct ChildPostData : Codable {
    var id : Int?
    var fullName : String?
    var userName : String?
    var createdTime : String?
    var accountType : String?
    var accountActivated : Int?
    var deviceType : String?
    var grade : String?
    var dateOfBirth : String?
    var childPassword : String?
    var image : String?
    var createdBy : Int?
    var parentName : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case fullName = "full_name"
        case userName = "user_name"
        case createdTime = "created_time"
        case accountType = "account_type"
        case accountActivated = "account_activated"
        case deviceType = "device_type"
        case grade = "grade"
        case dateOfBirth = "date_of_birth"
        case childPassword = "child_password"
        case image = "image"
        case createdBy = "created_by"
        case parentName = "parent_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        createdTime = try values.decodeIfPresent(String.self, forKey: .createdTime)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        accountActivated = try values.decodeIfPresent(Int.self, forKey: .accountActivated)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        grade = try values.decodeIfPresent(String.self, forKey: .grade)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        childPassword = try values.decodeIfPresent(String.self, forKey: .childPassword)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        createdBy = try values.decodeIfPresent(Int.self, forKey: .createdBy)
        parentName = try values.decodeIfPresent(String.self, forKey: .parentName)
    }
    
    init() {
        
    }

}
