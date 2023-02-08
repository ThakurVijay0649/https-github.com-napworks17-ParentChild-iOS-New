//
//  File.swift
//  Parent App
//
//  Created by Nap Works on 02/02/23.
//

import Foundation

struct ChildDeleteModel: Codable {
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
