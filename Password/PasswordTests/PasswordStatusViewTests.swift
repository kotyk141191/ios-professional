//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Mykhailo Kotyk on 12.04.2024.
//

import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.criteriaViewFirst.isCriteriaMet)
        XCTAssertTrue(statusView.criteriaViewFirst.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.criteriaViewFirst.isCriteriaMet)
        XCTAssertTrue(statusView.criteriaViewFirst.isResetImage) // ⚪️
    }
}




class PasswordStatusViewTests_ShowCheckmarkOrRed_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.criteriaViewFirst.isCriteriaMet)
        XCTAssertTrue(statusView.criteriaViewFirst.isCheckMarkImage) //
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.criteriaViewFirst.isCriteriaMet)
        XCTAssertTrue(statusView.criteriaViewFirst.isXMarkImage) //
    }
}
