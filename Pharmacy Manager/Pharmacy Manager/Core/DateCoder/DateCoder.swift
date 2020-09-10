//
//  DateCoder.swift
//  KyivPost
//
//  Created by Anton Bal’ on 15.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

protocol DateCoderFormatter {
    func string(from: Date) -> String
    func date(from: String) -> Date?
    var dateFormat: String! { get }
}

extension DateFormatter: DateCoderFormatter {}

class DateCoder: Codable {
    class var formatter: DateCoderFormatter? {
        return nil
    }
    
    let value: Date
    
    init(date: Date) {
        value = date
    }
    
    func toString() -> String {
        if let formatter = type(of: self).formatter {
            return formatter.string(from: value)
        } else {
            return String(describing: value)
        }
    }
    
    required init(from decoder: Decoder) throws {
        let string = try String(from: decoder)
        
        if let formatter = type(of: self).formatter {
            if let date = formatter.date(from: string) {
                value = date
            } else {
                let context = DecodingError.Context(codingPath: decoder.codingPath,
                                                    debugDescription: """
                    Invalid date format, expected \(String(describing: formatter.dateFormat)), actual \(string)
                    """)
                throw DecodingError.dataCorrupted(context)
            }
        } else {
            value = try Date(from: decoder)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        if let formatter = type(of: self).formatter {
            try formatter.string(from: value).encode(to: encoder)
        } else {
            try value.encode(to: encoder)
        }
    }
}
