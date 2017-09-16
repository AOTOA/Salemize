//
//  SMFunctions.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit

func SMLocalized(_ string: String, replaces: String...) -> String {
    var result: String = NSLocalizedString(string, tableName: Config.language, comment: "")
    for rep in replaces {
        if let range: Range = result.range(of: "%@") {
            result = result.replacingCharacters(in: range, with: rep)
        }
    }
    return result
}

func SMPersian(_ string: String) -> String {
    var result = String(format: string, locale: Locale(identifier: "fa_IR"))
    let numbers: [String:String] = ["1": "۱", "2": "۲", "3": "۳", "4": "۴", "5": "۵", "6": "۶", "7": "۷", "8": "۸", "9": "۹", "0": "۰"]
    for number in numbers {
        result = result.replacingOccurrences(of: number.key, with: number.value)
    }
    
    return result
}

func SMEnglish(_ string: String) -> String {
    var result = String(format: string, locale: Locale(identifier: "en_US"))
    let numbers: [String:String] = ["١": "1", "۲": "2", "۳": "3", "۴": "4", "۵": "5", "۶": "6", "۷": "7", "۸": "8", "۹": "9", "۰": "0"]
    for number in numbers {
        result = result.replacingOccurrences(of: number.key, with: number.value)
    }
    
    return result
}

func SMPersian(_ int: Int) -> String {
    return SMPersian("\(int)")
}

enum SMPersianDateType {
    case normal
    case dateOnly
    case justDistance
    case auto
}

func SMPersian(_ date: Date, type: SMPersianDateType = .normal) -> String {
    var calendar: Calendar = Calendar(identifier: .persian)
    calendar.locale = Locale(identifier: "fa_IR")
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "fa_IR")
    dateFormatter.calendar = calendar
    if type == .justDistance {
        let now = Date(timeIntervalSinceNow: 0)
        let distance = now.timeIntervalSince(date)
        if distance < 60 { // just this moment
            return SMLocalized("AS.Phrase.Date.Now")
        } else if distance < 3600 { // minutes ago
            return SMLocalized("AS.Phrase.Date.MinutesAgo", replaces: SMPersian(Int(distance / 60)))
        } else if distance < 3600 * 24 { // hours ago
            return SMLocalized("AS.Phrase.Date.HoursAgo", replaces: SMPersian(Int(distance / 3600)))
        } else if distance < 3600 * 24 * 31 { // days ago
            return SMLocalized("AS.Phrase.Date.DaysAgo", replaces: SMPersian(Int(distance / 3600 / 24)))
        } else if distance < 3600 * 24 * 366 {
            let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
            let currentDateComponents = calendar.dateComponents([.day, .month, .year], from: now)
            let cMonth: Int = (currentDateComponents.month)!
            let fMonth: Int = (dateComponents.month)!
            var dMonth: Int = 0
            if (dateComponents.year)! == (currentDateComponents.year)! {
                dMonth = cMonth - fMonth
            } else {
                dMonth = 12 - fMonth + cMonth
            }
            return SMLocalized("AS.Phrase.Date.MonthsAgo", replaces: SMPersian(dMonth))
        } else {
            return SMLocalized("AS.Phrase.Date.YearsAgo", replaces: SMPersian(Int(distance / 365.25 / 3600 / 24)))
        }
    } else if type == .auto {
        let now = Date(timeIntervalSinceNow: 0)
        let distance = now.timeIntervalSince(date)
        if distance < 60 { // just this moment
            return SMLocalized("AS.Phrase.Date.Now")
        } else if distance < 3600 { // minutes ago
            return SMLocalized("AS.Phrase.Date.MinutesAgo", replaces: SMPersian(Int(distance / 60)))
        } else if distance < 3600 * 24 { // hours ago
            return SMLocalized("AS.Phrase.Date.HoursAgo", replaces: SMPersian(Int(distance / 3600)))
        } else if distance < 3600 * 24 * 31 { // days ago
            return SMLocalized("AS.Phrase.Date.DaysAgo", replaces: SMPersian(Int(distance / 3600 / 24)))
        } else if distance < 3600 * 24 * 365 { // month and day
            dateFormatter.dateFormat = "dd MMMM"
            return dateFormatter.string(from: date)
        } else { // month, year and day
            dateFormatter.dateFormat = "dd MMMM yy"
            return dateFormatter.string(from: date)
        }
    } else if type == .dateOnly {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
    return dateFormatter.string(from: date)
}

