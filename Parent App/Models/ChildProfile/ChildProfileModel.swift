//
//  ChildProfileModel.swift
//  Parent App
//
//  Created by Nap Works on 03/02/23.
//

import Foundation

struct ChildProfileModel : Codable {
    let status : Int?
    let message : String?
    let userData : ChildProfileData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case userData = "userData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(ChildProfileData.self, forKey: .userData)
    }

}


struct ChildProfileData : Codable {
    let id : Int?
    let auth : String?
    let session : String?
    let full_name : String?
    let user_name : String?
    let created_time : String?
    let last_login_time : String?
    let fcm_token : String?
    let account_type : String?
    let account_activated : Int?
    let device_type : String?
    let grade : String?
    let date_of_birth : String?
    let child_password : String?
    let image : String?
    let created_by : Int?
    let parent_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case auth = "auth"
        case session = "session"
        case full_name = "full_name"
        case user_name = "user_name"
        case created_time = "created_time"
        case last_login_time = "last_login_time"
        case fcm_token = "fcm_token"
        case account_type = "account_type"
        case account_activated = "account_activated"
        case device_type = "device_type"
        case grade = "grade"
        case date_of_birth = "date_of_birth"
        case child_password = "child_password"
        case image = "image"
        case created_by = "created_by"
        case parent_name = "parent_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        auth = try values.decodeIfPresent(String.self, forKey: .auth)
        session = try values.decodeIfPresent(String.self, forKey: .session)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        created_time = try values.decodeIfPresent(String.self, forKey: .created_time)
        last_login_time = try values.decodeIfPresent(String.self, forKey: .last_login_time)
        fcm_token = try values.decodeIfPresent(String.self, forKey: .fcm_token)
        account_type = try values.decodeIfPresent(String.self, forKey: .account_type)
        account_activated = try values.decodeIfPresent(Int.self, forKey: .account_activated)
        device_type = try values.decodeIfPresent(String.self, forKey: .device_type)
        grade = try values.decodeIfPresent(String.self, forKey: .grade)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        child_password = try values.decodeIfPresent(String.self, forKey: .child_password)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        created_by = try values.decodeIfPresent(Int.self, forKey: .created_by)
        parent_name = try values.decodeIfPresent(String.self, forKey: .parent_name)
    }

}


struct UpdateChildProfileModel : Codable {
    let status : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
