//
//  PostModel.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation

struct PostElement: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Posts = [PostElement]
