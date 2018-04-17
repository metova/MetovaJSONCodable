//
//  MetovaJSONCodableTests.swift
//  MetovaJSONCodableTests
//
//  Created by Kalan Stowe on 4/10/18.
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

struct Test: JSONCodable {
    var testID: Int
    var email: String
    var testOptional: String?
    var testEnum: TestStringEnum
}

enum TestStringEnum: String, Codable {
    case testMatch
    case testNoMatch = "NoMatch"
}

class MetovaJSONCodableTests: XCTestCase {
    
    let validTestJSON: JSON = [
        "testID": 1,
        "email": "test@email.com",
        "testOptional": "optional",
        "testEnum": "testMatch"
    ]
    
    let validTestJSONWithNil: JSON = [
        "testID": 2,
        "email": "test@optional.com",
        "testOptional": Optional<String>.none as Any,
        "testEnum": "testMatch"
    ]
    
    let invalidTestJSON: JSON = [
        "testID": 3,
        "email": "test@email.com",
        "testEnum": "failState"
    ]
    
    func testDecodeSuccess() {
        
        guard let testMatch = Test(from: validTestJSON) else {
            XCTFail("Failed to decode Test object from json: \(validTestJSON)")
            return
        }
        
        XCTAssertEqual(testMatch.testID, 1)
        XCTAssertEqual(testMatch.email, "test@email.com")
        XCTAssertEqual(testMatch.testOptional, "optional")
        XCTAssertEqual(testMatch.testEnum, TestStringEnum.testMatch)
    }
    
    func testDecodeFailure() {
        
        let testNil = Test(from: invalidTestJSON)
        
        XCTAssertNil(testNil)
    }
    
    func testDecodeSuccessWithNil() {
        
        guard let testWithNil = Test(from: validTestJSONWithNil) else {
            XCTFail("Failed to decode Test object from json: \(validTestJSONWithNil)")
            return
        }
        
        XCTAssertEqual(testWithNil.testID, 2)
        XCTAssertEqual(testWithNil.email, "test@optional.com")
        XCTAssertNil(testWithNil.testOptional)
        XCTAssertEqual(testWithNil.testEnum, TestStringEnum.testMatch)
    }
    
    func testDecodeFromDataSuccess() {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: validTestJSON)
            
            guard let testFromData = Test(from: data) else {
                XCTFail("Failed to decode Test object from data")
                return
            }
            
            XCTAssertEqual(testFromData.testID, 1)
            XCTAssertEqual(testFromData.email, "test@email.com")
            XCTAssertEqual(testFromData.testEnum, TestStringEnum.testMatch)
        }
        catch {
            XCTFail("Failed to serialize JSON into data from json: \(validTestJSON)")
        }
    }
    
    func testDecodeFromDataFailure() {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: invalidTestJSON)
            
            let testNil = Test(from: data)
            
            XCTAssertNil(testNil)
        }
        catch {
            XCTFail("Failed to serialize JSON into data from json: \(validTestJSON)")
        }
    }
    
    func testEncode() {
        
        let testMatch = Test(testID: 1, email: "test@email.com", testOptional: "optional", testEnum: TestStringEnum.testMatch)
        
        guard var encodedJson = testMatch.jsonValue else {
            XCTFail("Failed to encode Test Object")
            return
        }
        
        XCTAssertEqual(encodedJson["testID"] as? Int, 1)
        XCTAssertEqual(encodedJson["email"] as? String, "test@email.com")
        XCTAssertEqual(encodedJson["testOptional"] as? String, "optional")
        XCTAssertEqual(encodedJson["testEnum"] as? String, "testMatch")
        
        let testNoMatch = Test(testID: 3, email: "test@test.com", testOptional: "optional", testEnum: TestStringEnum.testNoMatch)
        
        guard var encodedJsonNoMatch = testNoMatch.jsonValue else {
            XCTFail("Failed to encode Test Object")
            return
        }
        
        XCTAssertEqual(encodedJsonNoMatch["testID"] as? Int, 3)
        XCTAssertEqual(encodedJsonNoMatch["email"] as? String, "test@test.com")
        XCTAssertEqual(encodedJson["testOptional"] as? String, "optional")
        XCTAssertEqual(encodedJsonNoMatch["testEnum"] as? String, "NoMatch")
        
        let testNil = Test(testID: 5, email: "test@nil.com", testOptional: nil, testEnum: TestStringEnum.testMatch)
        
        guard var encodedJsonWithNil = testNil.jsonValue else {
            XCTFail("Failed to encode Test Object")
            return
        }
        
        XCTAssertEqual(encodedJsonWithNil["testID"] as? Int, 5)
        XCTAssertEqual(encodedJsonWithNil["email"] as? String, "test@nil.com")
        XCTAssertNil(encodedJsonWithNil["testOptional"])
        XCTAssertEqual(encodedJsonWithNil["testEnum"] as? String, "testMatch")
    }
    
}
