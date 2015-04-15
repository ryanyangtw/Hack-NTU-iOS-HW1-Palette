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

class PaletteViewController: UIViewController {
  @IBOutlet weak var rSlider: UISlider!
  @IBOutlet weak var gSlider: UISlider!
  @IBOutlet weak var bSlider: UISlider!

  private let defaults = NSUserDefaults.standardUserDefaults()
  
  private struct ColorInfo {
    static let DefaultKey = "PaletteViewController.colorInfo"
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    if let colorHash = defaults.dictionaryForKey(ColorInfo.DefaultKey) as? [String: Float] {
      if let red = colorHash["red"], green = colorHash["green"], blue = colorHash["blue"] {
        initSliderValue(red: red , green: green, blue: blue)
        updateBackgroundColor(red: red , green: green, blue: blue)
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func doChange(sender: AnyObject) {
    
    updateBackgroundColor(red: rSlider.value, green: gSlider.value, blue: bSlider.value)
    recordColor()
  
  }
  
  
  func initSliderValue(#red: Float , green: Float, blue: Float) {
    rSlider.setValue(red, animated: true)
    gSlider.setValue(green, animated: true)
    bSlider.setValue(blue, animated: true)
  }
  
  func updateBackgroundColor(#red: Float , green: Float, blue: Float) {
    
    var color = UIColor(
      red: CGFloat(red),
      green: CGFloat(green),
      blue: CGFloat(blue),
      alpha: 1)
    
    self.view.backgroundColor = color

  }
  
  func recordColor() {
    // Record the colorInfo
    let colorDict = ["red": rSlider.value, "green": gSlider.value, "blue": bSlider.value];
    defaults.setObject(colorDict, forKey: ColorInfo.DefaultKey)
    defaults.synchronize()   // Force to wtite in disk immediately
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

