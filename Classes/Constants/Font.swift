//
//  Font.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    /// 11
    case small     = 11
    /// 14
    case medium    = 14
    /// 16
    case large     = 16
}

struct Font {
    
    static func light(size: FontSize) -> UIFont {
        return FontFamily.SanFrancisco.light.font(size: size)
    }
    
    static func regular(size: FontSize) -> UIFont {
        return FontFamily.SanFrancisco.regular.font(size: size)
    }
    
    static func bold(size: FontSize) -> UIFont {
        return FontFamily.SanFrancisco.bold.font(size: size)
    }
}

protocol FontConvertible {
    func font(size: FontSize) -> UIFont!
}

extension FontConvertible where Self: RawRepresentable, Self.RawValue == String {
    
    func font(size: FontSize) -> UIFont! {
        return UIFont(name: self.rawValue, size: size.rawValue)
    }
}

fileprivate struct FontFamily {
    
    enum SanFrancisco: String, FontConvertible {
        case light            = "HelveticaNeue-Light"
        case regular          = "HelveticaNeue"
        case bold             = "HelveticaNeue-Bold"
    }
}
