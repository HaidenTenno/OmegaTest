//
//  DateCounter.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import Foundation

final class DateCounter {
    
    static func getYearsFromDate(date: Date) -> Int {
        let years = Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
        return years > 0 ? years : 0
    }
    
    static func getDateFromString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)
        return date
    }
    
    static func getYearFromDate(date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date).year ?? 0
    }
}
