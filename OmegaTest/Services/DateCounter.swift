//
//  DateCounter.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 18.06.2021.
//

import Foundation

final class DateCounter {
    
    func getYearsFromDate(date: Date) -> Int {
        Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
    }
}
