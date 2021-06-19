//
//  FormValidator.swift
//  OmegaTest
//
//  Created by Петр Тартынских  on 19.06.2021.
//

import Foundation



final class FormValidator {
    
    static func getValidationErrors(firstName: String, lastName: String, age: String, pnone: String, email: String, password: String) -> [String] {
        var errors: [String] = []
        
        errors.append(contentsOf: validate(name: firstName))
        errors.append(contentsOf: validate(name: lastName))
        errors.append(contentsOf: validate(age: age))
        errors.append(contentsOf: validate(phone: pnone))
        errors.append(contentsOf: validate(email: email))
        errors.append(contentsOf: validate(password: password))
        
        return errors.removingDuplicates()
    }
}

// MARK: - Private
private extension FormValidator {
    
    static private func validate(name: String) -> [String] {
        var errors: [String] = []
        
        if !checkRegex(string: name, regex: "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$") {
            errors.append("Name must be in English")
        }
        
        return errors
    }
    
    static private func validate(age: String) -> [String] {
        var errors: [String] = []
        
        guard let intAge = Int(age) else {
            errors.append("Age must be a number")
            return errors
        }
        
        if intAge < 18 {
            errors.append("Age must be over 18")
        }
        
        return errors
    }
    
    static private func validate(phone: String) -> [String] {
        var errors: [String] = []
        
        if !checkRegex(string: phone, regex: #"^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$"#) {
            errors.append("Phone number must correspond to the format +7 (***) ***-**-**")
        }
        
        return errors
    }
    
    static private func validate(email: String) -> [String] {
        var errors: [String] = []
        
        if !checkRegex(string: email, regex: #"^\S+@\S+\.\S+$"#) {
            errors.append("Wrong email format")
        }
        
        return errors
    }
    
    static private func validate(password: String) -> [String] {
        var errors: [String] = []
        
        if password.count < 6 {
            errors.append("Password must have at least 6 symbols")
        }
        
        if !checkRegex(string: password, regex: "[a-z]") {
            errors.append("Password must contain lovercase letter")
        }
        
        if !checkRegex(string: password, regex: "[A-Z,А-Я]") {
            errors.append("Password must contain uppercase letter")
        }
        
        if !checkRegex(string: password, regex: "[0-9]") {
            errors.append("Password must contain a number")
        }
        
        return errors
    }
    
    static private func checkRegex(string: String, regex: String) -> Bool {
        
        if string.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil {
            return true
        }
        
        return false
    }
}
