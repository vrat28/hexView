//
//  HexCollectionViewLayout.swift
//  HexViewDemo
//
//  Created by Varun Rathi on 06/12/16.
//  Copyright © 2016 vrat28. All rights reserved.
//

import UIKit

class HexCollectionViewLayout: UICollectionViewFlowLayout {

    var editing:Bool?
    var direction:Int?
    
    var numbersOfItems:Int!
    var numberOfSections:Int?
    var contentSize:CGRect?
   // var itemSize:CGSize?
   
    override func prepare() {
        super.prepare()
        
    }
    

    override var collectionViewContentSize: CGSize {
        let collection = collectionView!
        let width = collection.bounds.size.width
        let height = collection.bounds.size.height
        
        return CGSize(width: width, height: height)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
       // contentSize = rect
        var array   =   [UICollectionViewLayoutAttributes]()
        
        for i in 0..<numberOfSections!
        {
            for  j in 0..<numbersOfItems
            {
                let attribute = layoutAttributesForItem(at: IndexPath(row:j, section:i))!
                array.append(attribute)
            }
        }
        return array
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes?
    {
        
      let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
     // attribute.center =
        let width = self.itemSize.width
        let height = self.itemSize.height
        
        let numberOfItemsInRow = 4 //Int(floor(contentSize!.size.width/itemSize.width))
        let column = Int(indexPath.row % numberOfItemsInRow)
        let row =   indexPath.row / numberOfItemsInRow
    
        var hOffset:CGFloat = 0
        if (row % 2 != 0)
        {
            hOffset = width/2
        }
        let centerX = CGFloat(column)*width + hOffset + width/2
        let centerY = 0.75*CGFloat(row)*height + height/2
        attribute.size = itemSize
        attribute.center = CGPoint(x: centerX, y: centerY)
    
        return attribute
    }
 
    
}
