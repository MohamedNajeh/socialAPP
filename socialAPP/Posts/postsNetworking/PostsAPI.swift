//
//  PostsAPI.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation
protocol PostsAPIProtocol {
    func getPosts(completion: @escaping (Result<Posts?, ErrorMessages>) -> Void)
}


class PostsAPI: BaseAPI<PostsNetworking>, PostsAPIProtocol {
    func getPosts(completion: @escaping (Result<Posts?, ErrorMessages>) -> Void) {
        self.fetchData(target: .getPosts, responseClass: Posts.self) { result in
            completion(result)
        }
    }
}
