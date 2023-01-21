//
//  MockAPIService.swift
//  socialAPPTests
//
//  Created by MohamedNajeh on 21/01/2023.
//


class MockApiService: PostsAPIProtocol {
    var isFetchPostsCalled = false
    func getPosts(completion: @escaping (Result<Posts?, ErrorMessages>) -> Void) {
        isFetchPostsCalled = true
    }
}


class MockCommentsApiService: CommentsAPIProtocol {
    var isFetchPostsCalled = false
    func getComments(postID: Int, completion: @escaping (Result<Comments?, ErrorMessages>) -> Void) {
        isFetchPostsCalled = true
    }
}
