//
//  GetChildData.swift
//  Parent App
//
//  Created by Nap Works on 01/02/23.
//

import Foundation
struct GetChildListModel : Codable {
    let status : Int?
    let message : String?
    let data : [ChildListData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([ChildListData].self, forKey: .data)
    }

}

struct ChildListData : Codable {
    let childId : Int?
    let image : String?
    let grade : String?
    let dateOfBirth : String?
    let fullName : String?
    let phoneNumber : String?
    let userName : String?

    enum CodingKeys: String, CodingKey {

        case childId = "childId"
        case image = "image"
        case grade = "grade"
        case dateOfBirth = "dateOfBirth"
        case fullName = "fullName"
        case phoneNumber = "phoneNumber"
        case userName = "userName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        childId = try values.decodeIfPresent(Int.self, forKey: .childId)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        grade = try values.decodeIfPresent(String.self, forKey: .grade)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }

}
