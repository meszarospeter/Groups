//
//  AppStyle.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

struct AppStyle {
    
    static func applyGlobalAppearance() {
        UINavigationBar.appearance().tintColor = AppStyle.Colors.tintColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: AppStyle.Colors.Text.primary, NSAttributedStringKey.font: Font.bold(size: .large)]
    }
    
    struct Colors {
        static let tintColor: UIColor = UIColor(named: .blueDark)
        
        struct Text {
            static let primary: UIColor = UIColor(named: .blueDark)
            static let secondary: UIColor = UIColor(named: .grayCoolFive)
        }
    }
}
