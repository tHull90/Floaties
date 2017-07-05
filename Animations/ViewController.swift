//
//  ViewController.swift
//  Animations
//
//  Created by Timothy Hull on 7/3/17.
//  Copyright © 2017 Sponti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
    
    fileprivate func generateAnimatedViews() {
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "BlueStar") : #imageLiteral(resourceName: "PinkStar") // 1
        let imageView = UIImageView(image: image) // 2
        
        let dimension = 20 + drand48() * 10 // 3
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension) // 4
        
        let animation = CAKeyframeAnimation(keyPath: "position") // 5
        animation.path = customPath().cgPath // 6
        animation.duration = 2 + drand48() * 3 // 7
        animation.fillMode = kCAFillModeForwards // 8
        animation.isRemovedOnCompletion = false // 9
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // 10
        imageView.layer.add(animation, forKey: nil) // 11
        
        view.addSubview(imageView) // 12
    }
    
}

// Curved horizontal path across screen
func customPath() -> UIBezierPath {
    let path = UIBezierPath() // 1
    path.move(to: CGPoint(x: 0, y: 200)) // 2
    
    let endPoint = CGPoint(x: 400, y: 200) // 3
    
    let randomYShift = 200 + drand48() * 300 // 4
    
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift) // 5
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift) // 6
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)  // 7
    return path // 8
}


class CurvedView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = customPath() // 1
        path.stroke() // 2
    }
}
