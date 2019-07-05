//
//  GojekContactsTests.swift
//  GojekContactsTests
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import XCTest
@testable import GojekContacts

class GojekContactsTests: XCTestCase {
    
    func testHasFetchedContacts() {
        let expect = expectation(description: "Fetching contacts")
        
        DataManager.shared.fetchAllContacts { (result, error) in
            XCTAssertNil(error, "Error occured.")
            XCTAssertNotNil(result, "No result found.")
            expect.fulfill()
        }
        waitForExpectations(timeout: 20) { (error) in
            XCTAssertNil(error, "Test timed out.")
        }
    }
    func testHasFetchedContact() {
        let id = 20
        let expect = expectation(description: "Fetching contact")
        DataManager.shared.fetchContact(for: id) { (result, error) in
            XCTAssertNil(error, "Error occured.")
            XCTAssertNotNil(result, "No result found.")
            expect.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test timed out.")
        }
    }
    func testHasAddedContact() {

        let expect = expectation(description: "Adding contact")
        var parameters = Parameters()
        parameters["first_name"] = "Test"
        parameters["last_name"] = "Only"
        parameters["phone_number"] = "09232345684"
        parameters["favorite"] = true
  
        DataManager.shared.addContact(item: parameters) { (result, error) in
            XCTAssertNil(error, "Error occured.")
            XCTAssertNotNil(result, "No result found.")
            expect.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test timed out.")
        }
    }
    func testHasDownloadedImage() {
        let url = "https://i.imgur.com/UsdVp7H.jpg"
        let expect = expectation(description: "Adding contact")
        
        DataManager.shared.downloadImage(url: url) { (data, error) in
            XCTAssertNil(error, "Error occured.")
            XCTAssertNotNil(data, "No result found.")
            let image = data?.toImage()
            XCTAssertNotNil(image, "Data is not image.")
            expect.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "Test timed out.")
        }
    }
}
