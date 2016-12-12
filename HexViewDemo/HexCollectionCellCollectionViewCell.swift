//
//  HexCollectionCellCollectionViewCell.swift
//  HexViewDemo
//
//  Created by Varun Rathi on 05/12/16.
//  Copyright © 2016 vrat28. All rights reserved.
//

import UIKit

class HexCollectionCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellHexView: UIView?
    @IBOutlet weak var imageView:UIImageView!
 
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        NotificationCenter.default.addObserver(self, selector: #selector(startFlipAnimation(notification:)), name: NSNotification.Name(rawValue: "animate"), object: nil)
        
    }
    
    func startFlipAnimation(notification:NSNotification)
     {

//        guard let dic = notification.userInfo as? [String:Int]
//        else
//       {
//        return
//        }
        
        let direction = 1//dic["animation"]
        var transformation:CGAffineTransform?
        var animationOptions:UIViewAnimationOptions?
        
        if self.contentView.transform == CGAffineTransform.identity{
            animationOptions! = UIViewAnimationOptions.transitionFlipFromLeft
            if direction == 1 { transformation = CGAffineTransform(scaleX: -1, y: 1) ; }
            else {transformation = CGAffineTransform.identity}
        }
        else{
            animationOptions! = UIViewAnimationOptions.transitionFlipFromRight
            if direction == 1 {transformation = CGAffineTransform.identity}
            else {transformation = CGAffineTransform(scaleX: 1, y: 1)}
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options:[animationOptions!,UIViewAnimationOptions.curveEaseOut] , animations: {
                self.contentView.transform = transformation!
            }, completion:
            nil)
        }


    override func prepareForReuse() {
       // NotificationCenter.default.removeObserver(self)
         NotificationCenter.default.addObserver(self, selector: #selector(startFlipAnimation), name: NSNotification.Name(rawValue: "animate"), object: nil)
    }
    

}
