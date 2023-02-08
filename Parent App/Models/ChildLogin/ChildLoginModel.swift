//
//  ChildLogin.swift
//  Parent App
//
//  Created by Nap Works on 07/02/23.
//

import Foundation

struct ChildLoginModel : Codable {
    let status : Int?
    let message : String?
    let userData : ChildLoginData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case userData = "userData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(ChildLoginData.self, forKey: .userData)
    }

}


struct ChildLoginData : Codable {
    let id : Int?
    let auth : String?
    let session : String?
    let fullName : String?
    let userName : String?
    let createdTime : String?
    let lastLoginTime : String?
    let fcmToken : String?
    let accountType : String?
    let accountActivated : Int?
    let deviceType : String?
    let grade : String?
    let dateOfBirth : String?
    let childPassword : String?
    let image : String?
    let createdBy : Int?
    let parentName : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case auth = "auth"
        case session = "session"
        case fullName = "full_name"
        case userName = "user_name"
        case createdTime = "created_time"
        case lastLoginTime = "last_login_time"
        case fcmToken = "fcm_token"
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
        auth = try values.decodeIfPresent(String.self, forKey: .auth)
        session = try values.decodeIfPresent(String.self, forKey: .session)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        createdTime = try values.decodeIfPresent(String.self, forKey: .createdTime)
        lastLoginTime = try values.decodeIfPresent(String.self, forKey: .lastLoginTime)
        fcmToken = try values.decodeIfPresent(String.self, forKey: .fcmToken)
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

}
