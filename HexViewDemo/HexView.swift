//
//  HexView.swift
//  HexViewDemo
//
//  Created by Varun Rathi on 05/12/16.
//  Copyright © 2016 vrat28. All rights reserved.
//

import UIKit

class HexView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.red
        
    }
    
    override func draw(_ rect: CGRect) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = kCAFillRuleEvenOdd
        maskLayer.frame = self.bounds
        
        let width = self.frame.size.width
        let height = self.frame.size.height
         let hPadding = width * 1 / 8 / 6
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width/2, y: 0))
        path.addLine(to: CGPoint(x: width - hPadding, y: height / 4))
        path.addLine(to: CGPoint(x: width - hPadding, y: height * 3/4))
        path.addLine(to: CGPoint(x: width / 2, y: height))
        path.addLine(to: CGPoint(x: hPadding, y: height * 3/4))
        path.addLine(to: CGPoint(x: hPadding, y: height/4))
        path.close()
        path.close()
        
        UIColor.red.setFill()
        path.fill()
        UIColor.black.setStroke()
        path.stroke()

        maskLayer.path = path.cgPath
        UIGraphicsEndImageContext()
        self.layer.mask = maskLayer
        self.backgroundColor = UIColor.black
        
    }
}
