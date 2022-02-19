//
//  RequiredTaskTests.swift
//  NALS_TestTests
//
//  Created by Thien Luong Q. VN.Danang on 19/02/2022.
//

import XCTest
@testable import NALS_Test
import OHHTTPStubs

class RequiredTaskTests: XCTestCase {
    
    var viewModel: UserProfileViewModel!

    override func setUp() {
        let user = User()
        user.login = "2"
        viewModel = UserProfileViewModel(user: user)
    }

    override func tearDown() {
        viewModel = nil
    }

    func test_getUserProfile()  {
        stub(condition: isHost("api.github.com")) { _ in
            let stubPath = OHPathForFile("UserProfileResult.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        let promise = expectation(description: "Request Success")
        viewModel.getUserProfile { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                XCTAssertTrue(this.viewModel.user?.userName == "hello")
                XCTAssertTrue(this.viewModel.user?.follower == 4)
                promise.fulfill()
            case .failure: break
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
