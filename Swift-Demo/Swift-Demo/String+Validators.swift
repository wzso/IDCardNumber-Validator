//
//  String+Validators.swift
//  Swift-Demo
//
//  Created by Zhishen Wen on 2018/4/10.
//  Copyright © 2018 0xa6a. All rights reserved.
//

import Foundation


extension String {
    /// 验证身份证号码
    func validateIDCardNumber() -> Bool {
        struct Static {
            fileprivate static let predicate: NSPredicate = {
                let regex = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
                let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regex])
                return predicate
            }()
            fileprivate static let provinceCodes = [
                "11", "12", "13", "14", "15",
                "21", "22", "23",
                "31", "32", "33", "34", "35", "36", "37",
                "41", "42", "43", "44", "45", "46",
                "50", "51", "52", "53", "54",
                "61", "62", "63", "64", "65",
                "71", "81", "82", "91"]
        }
        // 初步验证
        guard Static.predicate.evaluate(with: self) else {
            return false
        }
        // 验证省份代码。如果需要更精确的话，可以把前六位行政区划代码都列举出来比较。
        let provinceCode = String(self.prefix(2))
        guard Static.provinceCodes.contains(provinceCode) else {
            return false
        }
        if self.count == 15 {
            return self.validate15DigitsIDCardNumber()
        } else {
            return self.validate18DigitsIDCardNumber()
        }
    }
    
    /// 15位身份证号码验证。
    // 6位行政区划代码 + 6位出生日期码(yyMMdd) + 3位顺序码
    private func validate15DigitsIDCardNumber() -> Bool {
        let birthdate = "19\(self.substring(from: 6, to: 11)!)"
        return birthdate.validateBirthDate()
    }
    
    /// 18位身份证号码验证。
    // 6位行政区划代码 + 8位出生日期码(yyyyMMdd) + 3位顺序码 + 1位校验码
    private func validate18DigitsIDCardNumber() -> Bool {
        let birthdate = self.substring(from: 6, to: 13)!
        guard birthdate.validateBirthDate() else {
            return false
        }
        struct Static {
            static let weights = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2]
            static let validationCodes = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]
        }
        // 验证校验位
        let digits = self.substring(from: 0, to: 16)!.map { Int("\($0)")! }
        var sum = 0
        for i in 0..<Static.weights.count {
            sum += Static.weights[i] * digits[i]
        }
        let mod11 = sum % 11
        let validationCode = Static.validationCodes[mod11]
        return hasSuffix(validationCode)
    }
    
    private func validateBirthDate() -> Bool {
        struct Static {
            static let dateFormatter: DateFormatter = {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMdd"
                return dateFormatter
            }()
        }
        if let _ = Static.dateFormatter.date(from: self) {
            return true
        } else {
            return false
        }
    }
    
    private func substring(from: Int, to: Int) -> String? {
        guard to >= from && from >= 0 && to < count else {
            return nil
        }
        let startIdx = self.index(startIndex, offsetBy: from)
        let endIdx = self.index(startIndex, offsetBy: to)
        return String(self[startIdx...endIdx])
    }
}
