//
//  Theme.swift
//  TerraTheme
//
//  Created by Tung Nguyen on 2/18/21.
//  Copyright © 2021 Teko. All rights reserved.
//

import Foundation
import UIKit

public struct ColorSet: Decodable {
    public var _50: UIColor?
    public var _100: UIColor?
    public var _200: UIColor?
    
    enum CodingKeys: String, CodingKey {
        case _50 = "color_50"
        case _100 = "color_100"
        case _200 = "color_200"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _50 = UIColor.from(hex: try values.decode(String.self, forKey: ._50))
        _100 = UIColor.from(hex: try values.decode(String.self, forKey: ._100))
        _200 = UIColor.from(hex: try values.decode(String.self, forKey: ._200))
    }
}

// SDK ----> terraApp.theme ---->
// When initSDK with terraApp -> subscribe to theme 
// When terraApp load ----> configure new theme to terraApp name ----> post NSNotification
// view controller with bundle id ---> subscribe bundle
// nhiều bundle cùng ~~~~ terraApp


public class Theme: NSObject, Decodable {
    public var appName: String?
    public var primary: ColorSet?
    public var secondary: ColorSet?
    
    public static func sample() -> Theme {
        let jsonString = """
        {
            "primary": {
                "color_50": "#FF8C90",
                "color_100": "#EE112E",
                "color_200": "#A10020",
            },
            "secondary": {
                "color_50": "#82CBFF",
                "color_100": "#0674EB",
                "color_200": "#00419C",
            }
        }
        """
        let data = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(Theme.self, from: data)
    }
    
    public static func sample2() -> Theme {
        let jsonString = """
        {
            "primary": {
                "color_50": "#87F1FF",
                "color_100": "#5FE7FF",
                "color_200": "#1F718C",
            },
            "secondary": {
                "color_50": "#98ABC6",
                "color_100": "#334A67",
                "color_200": "#142740",
            }
        }
        """
        let data = jsonString.data(using: .utf8)!
        return try! JSONDecoder().decode(Theme.self, from: data)
    }
}

extension UIColor {
    
    static func from(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        
    }
}
