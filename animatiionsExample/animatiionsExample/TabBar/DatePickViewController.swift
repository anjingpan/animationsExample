//
//  DatePickViewController.swift
//  animatiionsExample
//
//  Created by Jal on 2019/4/9.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit

class DatePickViewController: UIViewController,TabBarReplaceable {

    // MARK: - Property
    fileprivate lazy var replacedView: ClockView = {
        let clockView = ClockView()
        return clockView
    }()
    
    fileprivate lazy var pickview: UIDatePicker = {
        let pickView = UIDatePicker()
        pickView.backgroundColor = .white
        pickView.datePickerMode = .time
        pickView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickView)
        return pickView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        replacedView.backgroundColor = tabBarController?.tabBar.tintColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        replacedView.backgroundColor = .gray
    }
    
    // MARK: - UI
    func setupView() {
        replaceImageView(replacedView, CGSize(width: 24, height: 24))
        replacedView.layer.cornerRadius = replacedView.frame.width * 0.5
        
        var originComponents = DateComponents()
        originComponents.hour = 9
        originComponents.minute = 0
        pickview.date = Calendar.current.date(from: originComponents)!
        pickview.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            pickview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickview.leftAnchor.constraint(equalTo: view.leftAnchor),
            pickview.rightAnchor.constraint(equalTo: view.rightAnchor),
            pickview.heightAnchor.constraint(equalToConstant: 240)
        ])
        
    }
    
    // MARK: - Action
    @objc func dateChanged(_ sender: UIDatePicker) {
        let date = sender.date
        let current = Calendar.current
        replacedView.hour = current.component(.hour, from: date)
        replacedView.minute = current.component(.minute, from: date)
    }

}
