//
//  CurrencyFormatterTest.swift
//  BankeyAppUnitTests
//
//  Created by Mykhailo Kotyk on 26.03.2024.
//

import Foundation

import XCTest

@testable import BankeyApp

class  Test : XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    // Converts 929466 > $929,466.00
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    // Converts 929466 > 929,466
    func testZeroDollarsFormatted() throws {
        let result = formatter.convertDollar(929466)
        XCTAssertEqual(result, "929,466")
    }
    
    func testDollarsFormattedWithCurrencySymbol() throws {
        let locale = Locale(identifier: "en_US")
        let currencySymbol = locale.currencySymbol!
        
        let result = formatter.dollarsFormatted(929466.23)
        print("\(currencySymbol)")
        XCTAssertEqual(result, "\(currencySymbol)929,466.23")
        
    }
}
