//
//  ViewController.swift
//  Palette
//
//  Created by Appletone on 2014/8/8.
//  Copyright (c) 2014年 Appletone. All rights reserved.
//

import UIKit
// import social framwork
import Social

class ViewController: UIViewController {
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func doChange(sender: AnyObject) {
        
        var color = UIColor(
               red: CGFloat(rSlider.value),
             green: CGFloat(gSlider.value),
              blue: CGFloat(bSlider.value),
             alpha: 1)
        
        self.view.backgroundColor = color
        
    }
    
    func captureColor() -> UIImage {
      
        // 做snapshot
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 2)
        //UIGraphicsGetImageFromCurrentImageContext()
      
        // GraphicsGetCurrentContext() => 拿到目前的current context
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
      
        return image
    }
    
    @IBAction func doShare(sender: AnyObject) {
      // What is captureColor
        var image = captureColor()
        var compose = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        compose.addImage(image)
        compose.setInitialText("My favorite color!")
        self.presentViewController(compose, animated: true) { () -> Void in
            //
        }
        
    }
}

