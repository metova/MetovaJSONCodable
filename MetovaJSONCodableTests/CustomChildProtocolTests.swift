//
//  CustomChildProtocolTests.swift
//  MetovaJSONCodableTests
//
//  Created by Kalan Stowe on 4/12/18.
//  Copyright © 2018 Metova Inc.
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import MetovaJSONCodable

struct TestDateWithTimestamp: JSONEpochDateCodable {
    var testID: Int
    var email: String
    var testOptional: String?
    var testDate: Date
}

struct TestDateWithFormatter: JSONCustomDateFormatterCodable {
    var testID: Int
    var email: String
    var testDate: Date
    
    static var dateFormatter: DateFormatter {

        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return dateFormatter
    }
}

class CustomChildProtocolTests: XCTestCase {
 
    let validTestJSON: JSON = [
        "testID": 1,
        "email": "test@email.com",
        "testOptional": "optional",
        "testDate": 1523560533
    ]
    
    let invalidTestJSON: JSON = [
        "testID": 2,
        "email": "test@email.com",
        "testOptional": "optional",
        "testDate": "2001-09-11T17:56:27.000Z"
    ]
    
    let validTestJSONISO8601: JSON = [
        "testID": 2,
        "email": "test@email.com",
        "testDate": "2001-09-11T17:56:27.000Z"
    ]
    
    let invalidTestJSONISO8601: JSON = [
        "testID": 1,
        "email": "test@email.com",
        "testDate": 1523560533
    ]
    
    func testDecodeTimestampSuccess() {
        
        guard let testMatch = TestDateWithTimestamp(from: validTestJSON) else {
            XCTFail("Failed to decode Test object from json: \(validTestJSON)")
            return
        }
        
        XCTAssertEqual(testMatch.testID, 1)
        XCTAssertEqual(testMatch.email, "test@email.com")
        XCTAssertEqual(testMatch.testOptional, "optional")
        XCTAssertEqual(testMatch.testDate, NSDate(timeIntervalSince1970: 1523560533) as Date)
    }
    
    func testDecodeTimestampFailed() {
        
        let testInvalidDate = TestDateWithTimestamp(from: invalidTestJSON)
        
        XCTAssertNil(testInvalidDate)
    }
    
    func testEncodeTimestampSuccess() {
        
        let date = Date()
        
        let testMatch = TestDateWithTimestamp(testID: 3, email: "test@test.com", testOptional: nil, testDate: date)
        guard var encodedJson = testMatch.jsonValue else {
            XCTFail("Failed to encode Test Object")
            return
        }
        
        XCTAssertEqual(encodedJson["testID"] as? Int, 3)
        XCTAssertEqual(encodedJson["email"] as? String, "test@test.com")
        XCTAssertEqual(encodedJson["testDate"] as? Double, Double(date.timeIntervalSince1970))
    }
    
    func testDecodeWithDateFormatterSuccess() {
        
        guard let testMatch = TestDateWithFormatter(from: validTestJSONISO8601) else {
            XCTFail("Failed to decode Test object from json: \(validTestJSON)")
            return
        }
        
        let compareDate = TestDateWithFormatter.dateFormatter.date(from: "2001-09-11T17:56:27.000Z")
        
        XCTAssertEqual(testMatch.testID, 2)
        XCTAssertEqual(testMatch.email, "test@email.com")
        XCTAssertEqual(testMatch.testDate, compareDate)
    }
    
    func testDecodeWithDateFormatterFailed() {
        
        let testInvalidDate = TestDateWithFormatter(from: invalidTestJSONISO8601)
        
        XCTAssertNil(testInvalidDate)
    }
    
    func testEncodeDateFormatterSuccess() {
        
        let date = Date()
        
        let testMatch = TestDateWithFormatter(testID: 10, email: "new@test.com", testDate: date)
        
        let compareDate = TestDateWithFormatter.dateFormatter.string(from: date)
        
        guard var encodedJson = testMatch.jsonValue else {
            XCTFail("Failed to encode Test Object")
            return
        }
        
        XCTAssertEqual(encodedJson["testID"] as? Int, 10)
        XCTAssertEqual(encodedJson["email"] as? String, "new@test.com")
        XCTAssertEqual(encodedJson["testDate"] as? String, compareDate)
    }
}
