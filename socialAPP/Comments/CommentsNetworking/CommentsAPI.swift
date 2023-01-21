//
//  CommentsAPI.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation

protocol CommentsAPIProtocol {
    func getComments(postID:Int , completion: @escaping (Result<Comments?, ErrorMessages>) -> Void)
}


class CommentsAPI: BaseAPI<CommentsNetworking>, CommentsAPIProtocol {
    func getComments(postID: Int, completion: @escaping (Result<Comments?, ErrorMessages>) -> Void) {
        self.fetchData(target: .getComments(postID: postID), responseClass: Comments.self) { result in
            completion(result)
        }
    }
}
