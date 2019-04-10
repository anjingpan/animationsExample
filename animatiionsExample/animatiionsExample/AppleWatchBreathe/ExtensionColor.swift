//
//  ExtensionColor.swift
//  animatiionsExample
//
//  Created by yl on 2019/4/10.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit

extension UIColor {
    /// Get RGB From UIColor
    ///
    /// - Returns: RGB and Alpha 
    func getRGBFormColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat){
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
