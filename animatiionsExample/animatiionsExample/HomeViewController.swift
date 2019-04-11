//
//  ViewController.swift
//  animatiionsExample
//
//  Created by Jal on 2019/4/8.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Property
    fileprivate var animationArray = ["TabBar Animation", "Apple Watch Breathe Animation"]
    
    fileprivate lazy var scrollerView: UIScrollView = {
        let scroller = UIScrollView(frame: UIScreen.main.bounds)
        view.addSubview(scroller)
        return scroller
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        initView()
    }

    // MARK: - UI
    func initView() {
        for (index, title) in animationArray.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.frame = CGRect(x: 0, y: CGFloat(index) * 80 + 40 , width: UIScreen.main.bounds.width, height: 40)
            button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            button.tag = index
            scrollerView.addSubview(button)
        }
    }
    
    // MARK: - Action
    @objc func buttonClick(sender: UIButton) {
        if sender.tag == 0 {
            let tabBarItemFirst = UITabBarItem(title: "ClockFirst", image: UIImage(named: "Clock"), tag: 1)
            let firstVC = DatePickViewController()
            let firstNavigationController = UINavigationController(rootViewController: firstVC)
            firstNavigationController.tabBarItem = tabBarItemFirst
            
            let tabBarItemSecond = UITabBarItem(title: "ClockSecond", image: UIImage(named: "Clock"), tag: 2)
            let secondVC = DatePickViewController()
            let secondNavigationController = UINavigationController(rootViewController: secondVC)
            secondNavigationController.tabBarItem = tabBarItemSecond
            
            let tabBarController = UITabBarController()
            
            tabBarController.viewControllers = [firstNavigationController, secondNavigationController]
            navigationController?.pushViewController(tabBarController, animated: true)
            
            return
        }
        if sender.tag == 1 {
            let breatheVC = AppleWatchBreatheViewController()
            navigationController?.pushViewController(breatheVC, animated: true)
        }
    }

}
