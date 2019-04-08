//
//  TabBarReplaceable.swift
//  animatiionsExample
//
//  Created by Jal on 2019/4/8.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit

protocol TabBarReplaceable {
    /// Replace UITabBarView ImageView
    ///
    /// - Parameters:
    ///   - replacedView: view to replace
    ///   - size: if nil size equal to Origin ImageView Size
    func replaceImageView(_ replacedView: UIView, size: CGSize?)
}

extension TabBarReplaceable where Self: UIViewController {
    func replaceImageView(_ replacedView: UIView, _ size: CGSize?) {
        guard let tabBarController = self.parent as? UITabBarController else { return }
        
        var tabBarButtons = tabBarController.tabBar.subviews.filter({
            type(of: $0).description() == "UITabBarButton"
        })
        guard !tabBarButtons.isEmpty else { return }
        
        let currentButton = tabBarButtons[tabBarController.children.firstIndex(of: self)!]
        let imageViews = currentButton.subviews.filter({
            type(of: $0).description() == "UITabBarSwappableImageView"
        })
        
        guard !imageViews.isEmpty else { return }
        let imageView = imageViews.first!
        
        currentButton.addSubview(replacedView)
        imageView.isHidden = true
        replacedView.frame = imageView.bounds
    }
}
