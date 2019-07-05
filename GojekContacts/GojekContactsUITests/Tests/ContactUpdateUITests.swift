//
//  GojekContactsUITests.swift
//  GojekContactsUITests
//
//  Created by Glynvile Satago on 05/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import XCTest
@testable import GojekContacts

class GojekContactsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    func testInvalidAddContact() {
        
        let validFirstName = "Bill"
        let validLastName = "Last"
        let validMobile = "0958546985"
        let invalidEmail = "billgmailcom"
        
        let app = XCUIApplication()
        
        let addButton = app.navigationBars["Contact"].buttons["Add"]
        addButton.tap()
        
        let tablesQuery = app.tables
        let firstNameTextField = tablesQuery.cells.containing(.staticText, identifier:"First Name").children(matching: .textField).element
        let lastNameTextField = tablesQuery.cells.containing(.staticText, identifier:"Last Name").children(matching: .textField).element
        let mobileTextField = tablesQuery.cells.containing(.staticText, identifier:"mobile").children(matching: .textField).element
        let emailTextField = tablesQuery.cells.containing(.staticText, identifier:"email").children(matching: .textField).element
        
        firstNameTextField.tap()
        firstNameTextField.typeText(validFirstName)
        
        lastNameTextField.tap()
        lastNameTextField.typeText(validLastName)
        
        mobileTextField.tap()
        mobileTextField.typeText(validMobile)
        
        emailTextField.tap()
        emailTextField.typeText(invalidEmail)

        let doneButton = tablesQuery.buttons["Done"]
        doneButton.tap()
        
        let contactAlert = app.alerts["Contact"]
        contactAlert.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        XCTAssert(contactAlert.exists)
        contactAlert.buttons["Ok"].tap()
        
    }

}
