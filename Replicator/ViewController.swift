//
//  ViewController.swift
//  Replicator
//
//  Created by Alex Gibson on 10/14/16.
//  Copyright © 2016 AG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var replicatorView: ReplicatorView!

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        avatar.layoutIfNeeded()
        avatar.layer.cornerRadius = avatar.bounds.width/2
        avatar.layer.masksToBounds = true
        
        cardView.layoutIfNeeded()
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 5;
        cardView.layer.shadowOpacity = 0.5;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delay(delay: 3) { 

            self.replicatorView.animate()
            
            //prototype a network return
            delay(delay: 8, closure: { 
                self.replicatorView.stopAnimating()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }


}


// just used for protyping a network call
public func delay(delay:Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
