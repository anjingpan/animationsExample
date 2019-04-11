//
//  BreatheView.swift
//  animatiionsExample
//
//  Created by yl on 2019/4/10.
//  Copyright © 2019 anjing. All rights reserved.
//

import UIKit

class BreatheView: UIView {
    
    // MARK: - Property
    fileprivate var circleCount: Int = 6
    
    fileprivate var startCircleColor: UIColor = UIColor(red: 0.17, green: 0.59, blue: 0.60, alpha: 1)
    
    fileprivate var endCircleColor: UIColor = UIColor(red: 0.31, green: 0.85, blue: 0.62, alpha: 1)
    
    fileprivate var circleMinRadius: CGFloat = 24
    
    fileprivate var circleMaxRadius: CGFloat = 80
    
    fileprivate var animationDuration: Double = 10
    
    fileprivate lazy var breatheLayer: CAReplicatorLayer = {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.instanceCount = circleCount
        //绕z轴旋转
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat.pi * 2 / CGFloat(circleCount), 0, 0, 1)
        layer.addSublayer(replicatorLayer)
        return replicatorLayer
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        breatheLayer.frame = bounds
    }
    
    // MARK: - UI
    fileprivate func setupView() {
        backgroundColor = .black
        setupGradientColor()
        breatheLayer.addSublayer(initCircleLayer(center: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5), radius: circleMinRadius))
    }
    
    fileprivate func initCircleLayer(center: CGPoint, radius: CGFloat) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.white.cgColor
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.frame = bounds
        shapeLayer.compositingFilter = "screenBlendMode"
        return shapeLayer
    }
    
    /// set breatheLayer color
    fileprivate func setupGradientColor() {
        let startRGB = startCircleColor.getRGBFormColor()
        let endRGB = endCircleColor.getRGBFormColor()
        breatheLayer.instanceColor = startCircleColor.cgColor
        breatheLayer.instanceRedOffset = Float((endRGB.red - startRGB.red) / CGFloat(circleCount))
        breatheLayer.instanceGreenOffset = Float((endRGB.green - startRGB.green) / CGFloat(circleCount))
        breatheLayer.instanceBlueOffset = Float((endRGB.blue - startRGB.blue) / CGFloat(circleCount))
    }
    
    open func animate() {
        breatheLayer.sublayers?.forEach({
            $0.removeFromSuperlayer()
        })
        
        let circleLayer = initCircleLayer(center: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5), radius: circleMinRadius)
        breatheLayer.addSublayer(circleLayer)
        
        let moveAnimation = CAKeyframeAnimation(keyPath: "position.x")
        moveAnimation.values = [circleLayer.position.x, circleLayer.position.x - circleMaxRadius, circleLayer.position.x - circleMaxRadius, circleLayer.position.x]
        moveAnimation.keyTimes = [0.1, 0.4, 0.5, 0.95]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1, circleMaxRadius / circleMinRadius, circleMaxRadius / circleMinRadius , 1]
        scaleAnimation.keyTimes = [0.1, 0.4, 0.5, 0.95]
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [moveAnimation, scaleAnimation]
        configAnimation(animationGroup)
        circleLayer.add(animationGroup, forKey: nil)
        
        //rotation to breathLayer
        let rotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let angle = CGFloat.pi * 2 / CGFloat(circleCount)
        rotationAnimation.values = [-angle, angle, angle, -angle]
        rotationAnimation.keyTimes = [0.1, 0.4, 0.5, 0.95]
        configAnimation(rotationAnimation)
        breatheLayer.add(rotationAnimation, forKey: nil)

        //center need to Move
        let shadowCircleLayer = initCircleLayer(center: CGPoint(x: bounds.width * 0.5 - circleMaxRadius, y: bounds.height * 0.5), radius: circleMaxRadius)
        breatheLayer.addSublayer(shadowCircleLayer)
        shadowCircleLayer.opacity = 0

        let fadeoutAnimation = CAKeyframeAnimation(keyPath: "opacity")
        fadeoutAnimation.values = [0 ,0.3, 0]
        fadeoutAnimation.keyTimes = [0.45, 0.5, 0.8]
        
        let shadowScaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        shadowScaleAnimation.values = [1.0, 1.0, 0.78]
        shadowScaleAnimation.keyTimes = [0, 0.5, 0.8]
        
        let shadowAnimationGroup = CAAnimationGroup()
        shadowAnimationGroup.animations = [fadeoutAnimation, shadowScaleAnimation]
        configAnimation(shadowAnimationGroup)
        shadowCircleLayer.add(shadowAnimationGroup, forKey: nil)
        
    }
    
    ///set up animation
    fileprivate func configAnimation(_ animation: CAAnimation) {
        animation.duration = animationDuration
        animation.repeatCount = .infinity
    }
}
