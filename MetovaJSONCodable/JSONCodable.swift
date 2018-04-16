//
//  JSONCodable.swift
//  MetovaJSONCodable
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

import Foundation

/**
 Type alias for conforming to JSONDecodable & JSONEncodable. The same way Codable is a type alias for Decodable & Encodable
 */
public typealias JSONCodable = JSONDecodable & JSONEncodable

/**
 Type alias added for use as a shorthand json dictionary objects
 */
public typealias JSON = [String: Any]

/**
 JSONDecodable protocol with an init for JSON. Conforms to Decodable protocol
 */
public protocol JSONDecodable: Decodable {
    
    /**
     init from JSON object
     */
    init?(from json: JSON)
    
    /**
     init from JSON data
     */
    init?(from data: Data)
    
    /**
     Default JSONDecoder. This is mainly to be used by child protocols that need custom decoders
     */
    static var jsonDecoder: JSONDecoder { get }
}

public extension JSONDecodable {
    
    /**
     -return basic JSONDecoder. This is meant to be used by child protocols that need custom decoders
     */
    static var jsonDecoder: JSONDecoder {
        
        return JSONDecoder()
    }
    
    /**
     - return JSONDecodable object from JSON or nil if the decode fails
     */
    init?(from json: JSON) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            self = try Self.jsonDecoder.decode(Self.self, from: data)
        }
        catch {
            return nil
        }
    }
    
    /**
     - return JSONDecodable object from JSON Data or nil if the decode fails
     */
    init?(from data: Data) {
        
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        }
        catch {
            return nil
        }
    }
}

/**
 JSONEncodable protocol for easily getting a JSON object from a conforming JSONCodable object. Conforms to Encodable protocol
 */
public protocol JSONEncodable: Encodable {
    
    /**
     JSON representation of JSONCodable object
     */
    var jsonValue: JSON? { get }
    
    /**
     JSON data representation of JSONCodable object
     */
    var jsonData: Data? { get }
    
    /**
    * Deafult JSONEncoder. This is mainly to be used by child protocols that need custom encoders
    */
    static var jsonEncoder: JSONEncoder { get }
}

public extension JSONEncodable {
    
    /**
     -return basic JSONEncoder. This is meant to be used by child protocols that need custom encoders
     */
    static var jsonEncoder: JSONEncoder {
        
        return JSONEncoder()
    }
    
    /**
     - return data represendation of the JSONCodable object or nil if the encode fails
     */
    var jsonData: Data? {
        return try? Self.jsonEncoder.encode(self)
    }
    
    /**
     - return JSON represendation of the JSONCodable object or nil if the encode fails
     */
    var jsonValue: JSON? {
        
        guard let jsonData = jsonData else { return nil }
        
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData) as? JSON
            return json
        }
        catch {
            return nil
        }
    }
}
