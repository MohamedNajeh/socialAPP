//
//  CommentsTest.swift
//  socialAPPTests
//
//  Created by MohamedNajeh on 21/01/2023.
//

import XCTest
@testable import socialAPP
final class CommentsTest: XCTestCase {

    var mockAPISevice:MockCommentsApiService!
    var sut:CommentsViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPISevice = MockCommentsApiService()
        sut           = CommentsViewModel(apiService: mockAPISevice)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockAPISevice = nil
         try super.tearDownWithError()
    }

    func testExample() throws {
    
        sut.fetchCommnts(postID: 1)
        XCTAssert(mockAPISevice.isFetchPostsCalled)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
