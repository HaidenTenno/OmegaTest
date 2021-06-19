//
//  PhoneNumberFormatter.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 19.06.2021.
//

import Foundation

final class PnoneNumberFormatter {
    
    static func format(with mask: String, phone: String) -> String {
        let pnoneWithoutCode = phone.replacingOccurrences(of: "\\+7", with: "", options: .regularExpression)
        let numbers = pnoneWithoutCode.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}
