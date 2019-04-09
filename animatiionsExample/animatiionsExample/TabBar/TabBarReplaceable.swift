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
    func replaceImageView(_ replacedView: UIView, _ size: CGSize?)
}

extension TabBarReplaceable where Self: UIViewController {
    func replaceImageView(_ replacedView: UIView, _ size: CGSize?) {
        guard let tabBarController = findTabbarController() else { return }
        
        //防止拦截tabBar点击事件
        replacedView.isUserInteractionEnabled = false
        
        var tabBarButtons = tabBarController.tabBar.subviews.filter({
            type(of: $0).description() == "UITabBarButton"
        })
        guard !tabBarButtons.isEmpty else { return }
        
        let currentButton = tabBarButtons[tabBarController.selectedIndex]
        let imageViews = currentButton.subviews.filter({
            type(of: $0).description() == "UITabBarSwappableImageView"
        })
        
        guard !imageViews.isEmpty else { return }
        let imageView = imageViews.first!
        
        currentButton.addSubview(replacedView)
        imageView.isHidden = true
        replacedView.frame.size = size ?? imageView.frame.size
        replacedView.center = imageView.center
    }
    
    fileprivate func findTabbarController() -> UITabBarController? {
        var parent = self.parent
        while parent != nil {
            if let parent = parent as? UITabBarController {
                return parent
            }
            parent = parent?.parent
        }
        
        return nil
    }
}
