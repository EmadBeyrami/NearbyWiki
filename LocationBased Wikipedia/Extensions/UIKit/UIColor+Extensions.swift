//
//  UIColor+Extensions.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/4/21.
//

import UIKit

extension UIColor {
    
    private enum CustomColor: String {
        
        case blueberryBlue
        
        var color: UIColor {
            guard let color = UIColor(named: rawValue) else {
                assertionFailure("Color missing from asset catalogue")
                return .systemBlue
            }
            return color
        }
    }
    
    static var blueBerryBlue: UIColor = {
        CustomColor.blueberryBlue.color
    }()
}
