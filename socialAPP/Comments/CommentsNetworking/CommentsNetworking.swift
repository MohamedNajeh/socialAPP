//
//  CommentsNetworking.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation
import Alamofire

enum CommentsNetworking {
    case getComments(postID:Int)
}

extension CommentsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getComments:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getComments(let id):
            return "/posts/\(id)/comments"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getComments:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getComments:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
