//
//  AppleWatchBreatheViewController.swift
//  animatiionsExample
//
//  Created by yl on 2019/4/11.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit

class AppleWatchBreatheViewController: UIViewController {

    // MARK: - Property
    fileprivate lazy var breatheView: BreatheView = {
        let breathView = BreatheView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        breathView.center = view.center
        return breathView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        view.addSubview(breatheView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        breatheView.animate()
    }

}
