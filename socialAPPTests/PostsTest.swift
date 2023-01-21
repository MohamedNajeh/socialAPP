//
//  PostsTest.swift
//  socialAPPTests
//
//  Created by MohamedNajeh on 21/01/2023.
//

import XCTest
@testable import socialAPP
final class PostsTest: XCTestCase {

    var mockAPISevice:MockApiService!
    var sut:PostsViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPISevice = MockApiService()
        sut           = PostsViewModel(apiService: mockAPISevice)
    }

    override func tearDownWithError() throws {
       sut = nil
       mockAPISevice = nil
        try super.tearDownWithError()
    }

    func testExample() throws {

        sut.fetchPosts()
        XCTAssert(mockAPISevice.isFetchPostsCalled)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
