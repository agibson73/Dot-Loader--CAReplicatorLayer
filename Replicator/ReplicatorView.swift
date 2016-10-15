//
//  ReplicatorView.swift
//  Replicator
//
//  Created by Alex Gibson on 10/14/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

@IBDesignable class ReplicatorView: UIView {



    
    
    var loadingReplicator : CAReplicatorLayer!
    @IBInspectable var dotColor : UIColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1){
        didSet{
            setUp()
        }
    }
    
    @IBInspectable var dotSpace : CGFloat = 5{
        didSet{
            setUp()
        }
    }
    
    @IBInspectable var dotInstances : Int = 3{
        didSet{
            setUp()
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if loadingReplicator == nil{
            setUp()
        }
    }
    
    func setUp(){
        layoutIfNeeded()
        
        
        
        
        let dot = CALayer()
        dot.frame = CGRect(x: 0, y: 0, width: min(self.bounds.width, self.bounds.height), height: min(self.bounds.width, self.bounds.height))
        
        
        // now we know the frame
        var width = dot.frame.width
        //lets make sure our dots will fit
        if width * CGFloat(dotInstances) + (dotSpace * CGFloat(dotInstances - 1))  > self.bounds.width{
            width = (self.bounds.width / CGFloat(dotInstances)) - dotSpace 
            dot.frame = CGRect(x: 0, y: 0, width: width, height: width)
 
        }
        
        //find how much space we need between them
        let totalFreeSpace = self.bounds.width - (CGFloat(dotInstances) * width)
        let totalDotSpaceNeeded = dotSpace * CGFloat(dotInstances - 1)
        let unusedDotSpace = totalFreeSpace - totalDotSpaceNeeded
        
    
        dot.position = CGPoint(x: (unusedDotSpace/2) + width/2 , y: self.bounds.height/2)
        dot.backgroundColor = dotColor.cgColor
        dot.cornerRadius = dot.frame.width/2
        
        if loadingReplicator == nil{
            loadingReplicator = CAReplicatorLayer()
            loadingReplicator.addSublayer(dot)
            loadingReplicator.instanceCount = dotInstances
            loadingReplicator.instanceTransform = CATransform3DMakeTranslation(dotSpace + width, 0.0, 0.0)
            
            self.layer.addSublayer(loadingReplicator)
            
        }else{
            loadingReplicator.removeFromSuperlayer()
            loadingReplicator = CAReplicatorLayer()
            loadingReplicator.addSublayer(dot)
            loadingReplicator.instanceCount = dotInstances
            loadingReplicator.instanceTransform = CATransform3DMakeTranslation(dotSpace + width, 0.0, 0.0)
            
            self.layer.addSublayer(loadingReplicator)
            loadingReplicator.instanceTransform = CATransform3DMakeTranslation(dotSpace + width, 0.0, 0.0)
            loadingReplicator.instanceCount = dotInstances
        }
        
    }
    

    
    func animate(){
        guard  loadingReplicator != nil else {
            return
        }

        //get first instance
        if let caLayerInstance = loadingReplicator.sublayers?.first{
            caLayerInstance.removeAllAnimations()
            loadingReplicator.instanceDelay = Double(1) / Double(dotInstances)
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 1
            animation.toValue = 0
            animation.duration = 0.5
            animation.autoreverses = true
            animation.repeatCount = .infinity
            
            caLayerInstance.add(animation, forKey: nil)

        }

    }
    
    func stopAnimating(){
        guard  loadingReplicator != nil else {
            return
        }
        //get first instance
        if let caLayerInstance = loadingReplicator.sublayers?.first{
            
            let animation = CABasicAnimation(keyPath: "opacity")
        
            animation.toValue = 1
            animation.duration = 1
            CATransaction.begin()
            CATransaction.setCompletionBlock({ 
                caLayerInstance.removeAllAnimations()
            })
            caLayerInstance.add(animation, forKey: nil)
            CATransaction.commit()
        }
        
        
        
    }

}
