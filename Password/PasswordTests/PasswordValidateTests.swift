//
//  PasswordValidateTests.swift
//  PasswordTests
//
//  Created by Mykhailo Kotyk on 12.04.2024.
//

import XCTest

@testable import Password


class PasswordValidateTests: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    func testValidateTrue() throws {
        XCTAssertTrue(statusView.validate(validPassword))
        
        
    }
    
    func testValidateFalse() throws {
        
        XCTAssertFalse(statusView.validate(tooShort))
    }
}
