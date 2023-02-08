//
//  ChildImageModel.swift
//  Parent App
//
//  Created by Nap Works on 03/02/23.
//

import Foundation

struct ChildImageModel : Codable {
    let status : Int?
    let message : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
