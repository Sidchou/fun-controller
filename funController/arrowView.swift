//
//  arrowView.swift
//  funController
//
//  Created by ching Hsi chou on 3/6/19.
//  Copyright © 2019 ching Hsi chou. All rights reserved.
//

import UIKit

class arrowView: UIView {

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x, y: center.y-150))
        
        path.addLine(to: CGPoint(x: center.x*2-5, y: center.y))
        path.addLine(to: CGPoint(x: center.x*2-50, y: center.y))
        path.addLine(to: CGPoint(x: center.x*2-50, y: center.y*2-5))
        path.addLine(to: CGPoint(x: 50, y: center.y*2-5))
        path.addLine(to: CGPoint(x: 50, y: center.y))
        path.addLine(to: CGPoint(x: 5, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y-150))

        UIColor.cyan.setFill()
        path.fill()
        UIColor.black.setStroke()
        path.lineWidth = 2.5
        path.stroke()
        
    }
 

}
