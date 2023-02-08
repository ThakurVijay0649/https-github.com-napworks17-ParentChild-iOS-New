//
//  User.swift
//  Parent App
//
//  Created by Nap Works on 23/01/23.
//

import Foundation

/// Signup Model 
struct SignupModel : Codable {
    let status : Int?
    let message : String?
    let userData : UserData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case userData = "userData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(UserData.self, forKey: .userData)
    }

}

/// User Model
struct UserData : Codable {
    var id : Int?
    var auth : String?
    var session : String?
    var fullName : String?
    var email : String?
    var createdTime : String?
    var lastLoginTime : String?
    var fcmToken : String?
    var accountType : String?
    var accountActivated : Int?
    var deviceType : String?
    var loginType : String?
    var googleId : String?
    var facebookId : String?
    var profileProgressStep : Int?
    var image : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case auth = "auth"
        case session = "session"
        case fullName = "full_name"
        case email = "email"
        case createdTime = "created_time"
        case lastLoginTime = "last_login_time"
        case fcmToken = "fcm_token"
        case accountType = "account_type"
        case accountActivated = "account_activated"
        case deviceType = "device_type"
        case loginType = "login_type"
        case googleId = "google_id"
        case facebookId = "facebook_id"
        case profileProgressStep = "profileProgressStep"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        auth = try values.decodeIfPresent(String.self, forKey: .auth)
        session = try values.decodeIfPresent(String.self, forKey: .session)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        createdTime = try values.decodeIfPresent(String.self, forKey: .createdTime)
        lastLoginTime = try values.decodeIfPresent(String.self, forKey: .lastLoginTime)
        fcmToken = try values.decodeIfPresent(String.self, forKey: .fcmToken)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        accountActivated = try values.decodeIfPresent(Int.self, forKey: .accountActivated)
        deviceType = try values.decodeIfPresent(String.self, forKey: .deviceType)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        googleId = try values.decodeIfPresent(String.self, forKey: .googleId)
        facebookId = try values.decodeIfPresent(String.self, forKey: .facebookId)
        profileProgressStep = try values.decodeIfPresent(Int.self, forKey: .profileProgressStep)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
    
    init(){
        
    }

}
