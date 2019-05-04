//
//  LottieViewController.swift
//  animatiionsExample
//
//  Created by Jal on 2019/5/3.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {

    // MARK: - Property
    fileprivate lazy var animationView: LOTAnimationView = {
        let view = LOTAnimationView(name: "favourite")
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.center = self.view.center
        return view
    }()
    
    fileprivate var exitButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 20, y: 80, width: 40, height: 20))
        button.setTitle("退出", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(exitVC), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        view.backgroundColor = .lightGray
    }
    
    // MARK: - UI
    func setupView() {
        var subViews: [UIView] = [animationView]
        if navigationController == nil {
            subViews.append(exitButton)
        }
        
        subViews.forEach({ view.addSubview($0) })
    }
    
    // MARK: - Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animationView.play()
    }
    
    // MARK: - Action
    @objc func exitVC() {
        dismiss(animated: true, completion: nil)
    }

}
