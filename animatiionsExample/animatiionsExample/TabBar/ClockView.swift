//
//  ClockView.swift
//  animationsExample
//
//  Created by Jal on 2019/4/8.
//  Copyright © 2019 yl. All rights reserved.
//

import UIKit

class ClockView: UIView {

    // MARK: - Property
    open var hour: Int = 9 {
        didSet {
            hour = min(max(0, hour), 24)
            updateLayer()
        }
    }
    
    open var minute: Int = 0 {
        didSet {
            minute = min(max(0, minute), 60)
            updateLayer()
        }
    }
    
    open var hourWidth: CGFloat = 4 {
        didSet {
            hourLayer.bounds.size.width = hourWidth
            hourLayer.cornerRadius = hourWidth * 0.5
        }
    }
    
    //height = bounds.height * 0.5 - hourMarginHeight
    open var hourMarginHeight: CGFloat = 10 {
        didSet {
            hourLayer.bounds.size.height = bounds.height * 0.5 - hourMarginHeight
        }
    }
    
    open var minuteWidth: CGFloat = 4 {
        didSet {
            minuteLayer.bounds.size.width = minuteWidth
            minuteLayer.cornerRadius = minuteWidth * 0.5
        }
    }
    
    open var minuteMarginHeight: CGFloat = 6 {
        didSet {
            minuteLayer.bounds.size.height = bounds.height * 0.5 - minuteMarginHeight
        }
    }
    
    open var hourColor: UIColor = .white {
        didSet {
            hourLayer.backgroundColor = hourColor.cgColor
        }
    }
    
    open var minuteColor: UIColor = .white {
        didSet {
            minuteLayer.backgroundColor = minuteColor.cgColor
        }
    }
    
    //Hour Head Layer
    private lazy var hourLayer: CALayer = {
        return createNormalLayer()
    }()
    
    //Minute Head Layer
    private lazy var minuteLayer: CALayer = {
        return createNormalLayer()
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupOriginView()
    }
    
    // MARK: - UI
    func createNormalLayer() -> CALayer {
        let layer = CALayer()
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        layer.position = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        self.layer.addSublayer(layer)
        return layer
    }
    
    func setupOriginView() {
        backgroundColor = .lightGray
        hourLayer.bounds = CGRect(x: 0, y: 0, width: hourWidth, height: bounds.height * 0.5 - hourMarginHeight)
        hourLayer.cornerRadius = hourWidth * 0.5
        hourLayer.backgroundColor = hourColor.cgColor
        minuteLayer.bounds = CGRect(x: 0, y: 0, width: minuteWidth, height: bounds.width * 0.5 - minuteMarginHeight)
        minuteLayer.cornerRadius = minuteWidth * 0.5
        minuteLayer.backgroundColor = minuteColor.cgColor
        updateLayer()
    }
    
    func updateLayer() {
        var hourAngle = 2 * CGFloat.pi * CGFloat(hour) / 12
        //minute influence
        hourAngle += CGFloat.pi / 12 * CGFloat(minute) / 60
        hourLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1)
        
        let minuteAngle = 2 * CGFloat.pi * CGFloat(minute) / 60
        minuteLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
    }
    
}
