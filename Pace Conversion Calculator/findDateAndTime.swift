//
//  findDateAndTime.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/29/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

struct dateAndTime: Comparable, CustomStringConvertible {
    var description: String {
        if let time = arrayTime, let date = arrayDate {
            let hour = String(format: "%02d", time.hour)
            let minute = String(format: "%02d", time.minute)
            let second = String(format: "%02d", time.second)
            let day = String(format: "%02d", date.day)
            let month = String(format: "%02d", date.month)
            let year = String(format: "%02d", date.year)
            let stringTime = "\(hour):\(minute):\(second)"
            let stringDate = "\(month)/\(day)/\(year)"
            return "\(stringDate), \(stringTime)"
        } else {
            return "\(stringDate), \(stringTime)"
        }
    }
    
    
    
    static func == (lhs: dateAndTime, rhs: dateAndTime) -> Bool {
        if let lhsArrayDate = lhs.arrayDate, let rhsArrayDate = rhs.arrayDate, let lhsArrayTime = lhs.arrayDate, let rhsArrayTime = rhs.arrayTime {
            return lhs.date.year == rhs.date.year && lhs.date.month == rhs.date.month && lhs.date.day == rhs.date.day && lhs.time.hour == rhs.time.hour && lhs.time.minute == rhs.time.minute && lhs.time.second == rhs.time.second && lhsArrayDate == rhsArrayDate && lhsArrayTime == rhsArrayTime
        } else {
            return lhs.date.year == rhs.date.year && lhs.date.month == rhs.date.month && lhs.date.day == rhs.date.day && lhs.time.hour == rhs.time.hour && lhs.time.minute == rhs.time.minute && lhs.time.second == rhs.time.second
        }
    }
    
    static func < (lhs: dateAndTime, rhs: dateAndTime) -> Bool {
        if let lhsTime = lhs.arrayTime, let rhsTime = rhs.arrayTime, let lhsDate = lhs.arrayDate, let rhsDate = rhs.arrayDate {
            if lhsDate.year != rhsDate.year {
                return lhsDate.year < rhsDate.year
            } else if lhsDate.month != rhsDate.month {
                return lhsDate.month < rhsDate.month
            } else if lhsDate.day != rhsDate.day {
                return lhsDate.day < rhsDate.day
            } else if lhsTime.hour != rhsTime.hour {
                return lhsTime.hour < rhsTime.hour
            } else if lhsTime.minute != rhsTime.minute {
                return lhsTime.minute < rhsTime.minute
            } else {
                return lhsTime.second < rhsTime.second
            }
        } else {
            if lhs.date.year != rhs.date.year {
                return lhs.date.year < rhs.date.year
            } else if lhs.date.month != rhs.date.month {
                return lhs.date.month < rhs.date.month
            } else if lhs.date.day != rhs.date.day {
                return lhs.date.day < rhs.date.day
            } else if lhs.time.hour != rhs.time.hour {
                return lhs.time.hour < rhs.time.hour
            } else if lhs.time.minute != rhs.time.minute {
                return lhs.time.minute < rhs.time.minute
            } else {
                return lhs.time.second < rhs.time.second
            }
        }
    }
    
    var date: (month: Int, day: Int, year: Int) {
        get {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            let stringDate = formatter.string(from: date)
            let month = Int(stringDate.prefix(2))
            let startIndex = stringDate.index(stringDate.startIndex, offsetBy: 3)
            let endIndex = stringDate.index(stringDate.endIndex, offsetBy: -3)
            let day = Int(stringDate[startIndex..<endIndex])
            let year = Int(stringDate.suffix(2))
            return (month!, day!, year!)
        } set {
            arrayDate = newValue
        }
    }
    
    var arrayDate: (month: Int, day: Int, year: Int)?
    
    var stringDate: String {
        let month = String(format: "%02d", date.month)
        let day = String(format: "%02d", date.day)
        let year = String(format: "%02d", date.year)
        return "\(month)/\(day)/\(year)"
    }

    var time: (hour: Int, minute: Int, second: Int) {
        get {
            let date = Date()
            let calendar = Calendar.current
            let hour = Int(calendar.component(.hour, from: date))
            let minute = Int(calendar.component(.minute, from: date))
            let second = Int(calendar.component(.second, from: date))
            return (hour, minute, second)
        } set {
            arrayTime = newValue
        }
    }
    
    var arrayTime: (hour: Int, minute: Int, second: Int)?
    
    var stringTime: String {
        let hour = String(format: "%02d", time.hour)
        let minute = String(format: "%02d", time.minute)
        let second = String(format: "%02d", time.second)
        return "\(hour):\(minute):\(second)"
    }
}

extension String {
    var timeStructure: (Int, Int, Int) {
        let hour = Int(self.prefix(2))
        let startIndex = self.index(self.startIndex, offsetBy: 3)
        let endIndex = self.index(self.endIndex, offsetBy: -3)
        let minute = Int(self[startIndex..<endIndex])
        let second = Int(self.suffix(2))
        return (hour!, minute!, second!)
    }
    var dateStructure: (Int, Int, Int) {
        let month = Int(self.prefix(2))
        let startIndex = self.index(self.startIndex, offsetBy: 3)
        let endIndex = self.index(self.endIndex, offsetBy: -3)
        let day = Int(self[startIndex..<endIndex])
        let year = Int(self.suffix(2))
        return (month!, day!, year!)
    }
}
