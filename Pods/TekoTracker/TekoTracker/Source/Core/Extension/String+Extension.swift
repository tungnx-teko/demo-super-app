//
//  String+Extension.swift
//  TekoTracker
//
//  Created by Le Vu Huy on 10/16/20.
//

import Foundation

extension String {
    
    func replacingRegexMatches(pattern: String, with replacement: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replacement)
        } catch { return self }
    }
    
    func removeBreakLine() -> String {
        return replacingRegexMatches(pattern: #"\n|\\+n"#, with: "")
    }
    
}

extension Optional where Wrapped == String {
    
    func removeBreakLine() -> String? {
        return self?.replacingRegexMatches(pattern: #"\n|\\+n"#, with: "")
    }
    
}
