//
//  DateFormatter.swift
//  KyivPost
//
//  Created by Anton Bal’ on 09.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var monthDayTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, h:mm a"
        return formatter
    }

    static var commonWPFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }

    func stringWithWP(from string: String) -> String {
        return DateFormatter.monthDayTimeFormatter.stringWithLowerCasedAMPM(from: date(from: string) ?? Date())
    }

    func stringWithLowerCasedAMPM(from date: Date) -> String {
        string(from: date).replacingOccurrences(of: "AM", with: "am").replacingOccurrences(of: "PM", with: "pm")
    }
}


extension DateFormatter {
  static let commonDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
