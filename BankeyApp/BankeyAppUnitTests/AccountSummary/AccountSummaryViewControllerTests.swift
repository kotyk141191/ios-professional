//
//  AccountSummaryViewControllerTests.swift
//  BankeyAppUnitTests
//
//  Created by Mykhailo Kotyk on 01.04.2024.
//

import UIKit
import XCTest

@testable import BankeyApp

class  AccountSummaryViewControllerTests : XCTestCase {
    static var vc: AccountSummaryViewController!
    
    static var mockManager : MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
          var profile: Profile?
          var error: NetworkError?
          
          func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
              if error != nil {
                  completion(.failure(error!))
                  return
              }
              profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
              completion(.success(profile!))
          }
      }
    
    override class func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
//        vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        vc.profileManger = mockManager
    }
    
    func testServerError() throws {
        let titleAndMessage = AccountSummaryViewControllerTests.vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Enshure you are connected to the internet. Please try again", titleAndMessage.1)
    }
    
    func testDecodingError() throws {
        let titleAndMessage = AccountSummaryViewControllerTests.vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding error", titleAndMessage.0)
        XCTAssertEqual("We could not process you request. Please try again", titleAndMessage.1)
    }
    
    func titleAlertForServerError() throws {
        AccountSummaryViewControllerTests.mockManager.error = NetworkError.serverError
        AccountSummaryViewControllerTests.vc.forceFetchProfile()
        XCTAssertEqual("Server Error", AccountSummaryViewControllerTests.vc.errorAlert.title)
        XCTAssertEqual("Enshure you are connected to the internet. Please try again", AccountSummaryViewControllerTests.vc.errorAlert.message)
    }
    
    func titleAlertForDecoderError() throws {
        AccountSummaryViewControllerTests.mockManager.error = NetworkError.decodingError
        AccountSummaryViewControllerTests.vc.forceFetchProfile()
        XCTAssertEqual("Decoding error", AccountSummaryViewControllerTests.vc.errorAlert.title)
        XCTAssertEqual("We could not process you request. Please try again", AccountSummaryViewControllerTests.vc.errorAlert.message)
    }
}
