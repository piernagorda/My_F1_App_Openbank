//
//  LoginViewModelTests.swift
//  My F1Tests
//
//  Created by Piernagorda Olive Javier on 10/8/23.
//

import XCTest
@testable import My_F1

final class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let controller = LoginViewController()
        sut = LoginViewModel(loginView: controller)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginViewModel_whenLoginWithWrongEmailFormat_expectError() throws {
        let wrongEmail = "juan"
        let expectedResult = false
        XCTAssertTrue(expectedResult == sut!.verifyEmail(email: wrongEmail),
                      "The wrong email is not being detected")
    }
    
    func testLoginViewModel_whenLoginWithCorrectEmailFormat_expectSuccess() throws {
        let correctEmail = "juan@gmail.com"
        let expectedResult = true
        XCTAssertTrue(expectedResult == sut!.verifyEmail(email: correctEmail),
                      "The correct email is not being detected")
    }
    
    func testLoginViewModel_whenLoginWithWrongPasswordFormat_expectError() throws {
        let wrongPassword = "hola"
        let expectedResult = false
        XCTAssertTrue(expectedResult == sut!.verifyPassword(password: wrongPassword),
                      "The wrong password is not being detected")
    }
    
    func testLoginViewModel_whenLoginWithCorrectPasswordFormat_expectSuccess() throws {
        let correctPassword = "Pepito7*"
        let expectedResult = true
        XCTAssertTrue(expectedResult == sut!.verifyPassword(password: correctPassword),
                      "The correct password is not being detected")
    }
    
}
