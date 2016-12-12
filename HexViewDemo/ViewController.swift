//
//  ViewController.swift
//  HexViewDemo
//
//  Created by Varun Rathi on 05/12/16.
//  Copyright © 2016 vrat28. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView:UICollectionView!
    var gesture:UIPanGestureRecognizer?
    
    var flowLayout :HexCollectionViewLayout?

    var images:[UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flowLayout = HexCollectionViewLayout()
      //  flowLayout!.minimumLineSpacing  =   -20
        flowLayout!.itemSize = CGSize (width: 220, height: 200)
        flowLayout?.numbersOfItems = 16
        flowLayout?.numberOfSections = 1
        flowLayout?.minimumInteritemSpacing = -10
        flowLayout!.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionView.collectionViewLayout = flowLayout!
        
        gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        collectionView.addGestureRecognizer(gesture!)
        
        let image = UIImage(named: "wall")
        images = splitImage(image: image!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func splitImage(image:UIImage)->[UIImage]?
    {
        let rows:CGFloat = 4.0
        let cols:CGFloat = 4.0
        
        let width = CGFloat( image.size.width / cols)
        let height = image.size.height / rows
        var images = [UIImage]()
       
        var offsetY:CGFloat = 0
        for _ in 0..<Int(rows)
            {
                 var offsetX:CGFloat = 0
                for _ in 0..<Int(cols)
                {
                    let frame = CGRect(x: offsetX, y: offsetY, width: width, height: height)
                    let imageRef = image.cgImage!.cropping(to: frame)
                    let splitImage = UIImage(cgImage: imageRef!)
                    images.append(splitImage)
                    offsetX = offsetX + width
                }
            offsetY = offsetY + height
            }
        return images
    }
    
    // MARK : Gesture recognizers
    
    
    func handleGesture(gesture:UIPanGestureRecognizer)
    {
        let velocity:CGPoint = gesture.velocity(in: collectionView)
        self.collectionView.collectionViewLayout.invalidateLayout()
    
        var direction = 0
        if  velocity.x > 0
        {
           direction  = 0
        
        }
        else
        {
           direction  = 1
            collectionView.performBatchUpdates({
                self.flowLayout?.editing = true
                
                }, completion: nil)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "animate"), object: nil, userInfo: ["direction":direction])
    }
    
    // MARK : CollectionView delegates
 
    
    func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 16
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "hexCell"
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! HexCollectionCellCollectionViewCell
      //  cell.imageView.image = UIImage.init(named: "User")
        cell.imageView.image = images?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
       UIView.animate(withDuration: 0.2, delay: 0.0, options: [UIViewAnimationOptions.transitionFlipFromLeft,UIViewAnimationOptions.curveEaseOut], animations: {
        if cell!.contentView.transform == CGAffineTransform.identity
        {
           cell!.contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        else
        {
            cell!.contentView.transform = CGAffineTransform.identity
        }
            }, completion: nil)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

