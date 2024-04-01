//
//  InputValidatorTests.swift
//  NoteMeTests
//
//  Created by George Popkich on 26.03.24.
//

import XCTest
@testable import NoteMe

final class InputValidatorTests: XCTestCase {
    
    func test_validEmail() {
        let sut = InputValidator()
        let validEmail = "test_email@gmail.com"
        
        let result = sut.validate(email: validEmail)
        
        XCTAssert(result)
    }
    
    func test_invalidEmail() {
        let sut = InputValidator()
        let validEmail = "test@email@gmail.com"
        
        let result = sut.validate(email: validEmail)
        
        XCTAssertFalse(result)
    }
    
    func test_validDoubleExtention() {
        let sut = InputValidator()
        let validEmail = "test_email@gmail.com.by"
        
        let result = sut.validate(email: validEmail)
        
        XCTAssert(result)
    }
    
    func test_nillEmail() {
        let sut = InputValidator()
        let validEmail = ""
        
        let result = sut.validate(email: validEmail)
        
        XCTAssertFalse(result)
    }
    
}
