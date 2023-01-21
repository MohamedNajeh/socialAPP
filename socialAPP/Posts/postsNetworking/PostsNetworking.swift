//
//  PostsNetworking.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation
import Alamofire

enum PostsNetworking {
    case getPosts
}

extension PostsNetworking: TargetType {
    var baseURL: String {
        switch self {
        case .getPosts:
            return URLs.baseURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts:
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
