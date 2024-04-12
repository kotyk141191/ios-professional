//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Mykhailo Kotyk on 12.04.2024.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {

    // Boundary conditions 8-32
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123456789012345678901234567890123"))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))

    }

    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678901234567890123456789012"))

    }
}

class PasswordOtherCriteriaTests : XCTestCase {
    func testSpaceMet()  throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("fds dsdf"))
    }
}


class PasswordLengthAndNoSpaceCriteriaTests : XCTestCase {
    
    func testLengthAndNoSpaceMet()  throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("njksdafncv32"))
    }
    
    func testLengthAndNoSpaceNotMet()  throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("n jksda"))
    }
    
    
}


class PasswordUppercaseCriteriaTests : XCTestCase {
    
    func testUppercaseMet()  throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("njkdU"))
    }
    
    func testUppercaseNotMet()  throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("ndsvsdafba"))
    }
    
    
}

class PasswordLowercaseCriteriaTests : XCTestCase {
    
    func testLowercaseMet()  throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("njkdU"))
    }
    
    func testLowercaseNotMet()  throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("HJGKFN"))
    }
    
    
}


class PasswordDigitCriteriaTests : XCTestCase {
    
    func testDigitMet()  throws {
        XCTAssertTrue(PasswordCriteria.digitMet("nj34kdU"))
    }
    
    func testDigitNotMet()  throws {
        XCTAssertFalse(PasswordCriteria.digitMet("ndsvsdafba"))
    }
    
    
}

class PasswordSpecialCriteriaTests : XCTestCase {
    
    func testSpecialMet()  throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("nj$kdU"))
    }
    
    func testSpecialNotMet()  throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("ndsvsdafba"))
    }
    
    
}
