//
//  JSONCodable+DateHandling.swift
//  MetovaJSONCodable
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

import Foundation

// MARK: JSONEpochDateCodable

/**
 Type alias for conforming to JSONEpochDateDecodable & JSONEpochDateEncodable. The same way Codable is a type alias for Decodable & Encodable
 */
typealias JSONEpochDateCodable = JSONEpochDateDecodable & JSONEpochDateEncodable

/**
 JSONDecodable child protocol with support for dates as timestamps
 */
public protocol JSONEpochDateDecodable: JSONDecodable {}

public extension JSONEpochDateDecodable {
    
    /**
     - return JSONDecoder with date decoding strategy for Seconds since 1970
     */
    static var jsonDecoder: JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}

/**
 JSONEncodable child protocol with support for dates as timestamps
 */
public protocol JSONEpochDateEncodable: JSONEncodable {}

public extension JSONEpochDateEncodable {
    
    /**
     - return JSONDecoder with date encoding strategy for Seconds since 1970
     */
    static var jsonEncoder: JSONEncoder {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }
}

// MARK: JSONCodableWithCustomFormatter

/**
 Type alias for conforming to JSONCustomDateFormatterDecodable & JSONCustomDateFormatterEncodable. The same way Codable is a type alias for Decodable & Encodable
 */
public typealias JSONCustomDateFormatterCodable = JSONCustomDateFormatterDecodable & JSONCustomDateFormatterEncodable

/**
 JSONDecodable child protocol that allows the user to define a cust dateFormatter. There is no default dateFormatter defined here so any object conforming to the protocol will need to add this
 */
public protocol JSONCustomDateFormatterDecodable: JSONDecodable {
    
    /**
     Customizeable date formatter. This will need to be implemented by conforming objects
     */
    static var dateFormatter: DateFormatter { get }
}

public extension JSONCustomDateFormatterDecodable {
    
    /**
     - return JSONDecoder with custom date formatter that is user definable
     */
    static var jsonDecoder: JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Self.dateFormatter)
        return decoder
    }
}

/**
 JSONEncodable child protocol that allows the user to define a cust dateFormatter. There is no default dateFormatter defined here so any object conforming to the protocol will need to add this
 */
public protocol JSONCustomDateFormatterEncodable: JSONEncodable {
    
    /**
     Customizeable date formatter. This will need to be implemented by conforming objects
     */
    static var dateFormatter: DateFormatter { get }
}

public extension JSONCustomDateFormatterEncodable {
    
    /**
     - return JSONEncoder with custom date formatter that is user definable
     */
    static var jsonEncoder: JSONEncoder {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(Self.dateFormatter)
        return encoder
    }
}


