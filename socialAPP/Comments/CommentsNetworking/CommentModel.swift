//
//  CommentModel.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation
struct Comment: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias Comments = [Comment]
