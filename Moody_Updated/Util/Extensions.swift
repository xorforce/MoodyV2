//
//  Extensions.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit
import BRYXBanner

extension UIButton {
  func applyButtonStyling() {
    self.layer.cornerRadius = self.frame.height/2
    self.layer.borderWidth = 1.2
    self.layer.borderColor = Constants.Colors.primaryColor.cgColor
    self.backgroundColor = .clear
    self.setTitle("Done!", for: .normal)
    self.setTitleColor(Constants.Colors.primaryColor, for: .normal)
  }
}

extension UIViewController {
  
  func getRandomColor() -> String {
    
    var colorString = ""
    
    for i in 0..<6 {
      let color = arc4random_uniform(UInt32(255))
      if i != 5 {
        colorString = colorString + "\(color),"
      }
      else {
        colorString = colorString + "\(color)"
      }
    }
    
    return colorString
  }
  
  func getRGB(color1: UIColor, color2: UIColor?, single: Bool) -> String {
    
    var colorString = ""
    let r1 = color1.rgb()?.red
    let g1 = color1.rgb()?.green
    let b1 = color1.rgb()?.blue
    
    if let red = r1, let green = g1, let blue = b1 {
      colorString = "\(Int(red * 255)),\(Int(green * 255)),\(Int(blue * 255))"
    }
    
    if single {
      return colorString + colorString
    }
    else {
      guard let color2 = color2 else { return "" }
      let r2 = color2.rgb()?.red
      let g2 = color2.rgb()?.green
      let b2 = color2.rgb()?.blue
      if let red = r2, let green = g2, let blue = b2 {
        colorString = colorString + "\(Int(red * 255)),\(Int(green * 255)),\(Int(blue * 255))"
        return colorString
      }
    }
    return ""
  }
  
  func showBanner(title: String, subtitle: String, color: UIColor) {
    let banner = Banner(title: title, subtitle: subtitle, image: nil, backgroundColor: color, didTapBlock: nil)
    banner.dismissesOnTap = true
    banner.show(duration: 3.0)
  }
}

extension UIColor {
  
  public func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
    var fRed : CGFloat = 0
    var fGreen : CGFloat = 0
    var fBlue : CGFloat = 0
    var fAlpha: CGFloat = 0
    if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
      let iRed = Int(fRed)
      let iGreen = Int(fGreen)
      let iBlue = Int(fBlue)
      let iAlpha = Int(fAlpha)
      
      return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
    } else {
      // Could not extract RGBA components:
      return nil
    }
  }
}

extension UIView {
  
  func prepareForAutoLayout() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func alignLeft(to: UIView, padding: CGFloat) {
    self.leftAnchor.constraint(equalTo: to.leftAnchor, constant: padding).isActive = true
  }
  
  func centreX(to: UIView) {
    self.centerXAnchor.constraint(equalTo: to.centerXAnchor).isActive = true
  }
  
  func centreY(to: UIView) {
    self.centerYAnchor.constraint(equalTo: to.centerYAnchor).isActive = true
  }
  
  func alignRight(to: UIView, padding: CGFloat) {
    self.rightAnchor.constraint(equalTo: to.rightAnchor, constant: -padding).isActive = true
  }
  
  func alignTop(to: UIView, padding: CGFloat) {
    self.topAnchor.constraint(equalTo: to.topAnchor, constant: padding).isActive = true
  }
  
  func setBelow(to: UIView, padding: CGFloat) {
    self.topAnchor.constraint(equalTo: to.bottomAnchor, constant: padding).isActive = true
  }
  
  func alignBottom(to: UIView, padding: CGFloat) {
    self.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: padding).isActive = true
  }
  
  func alignWidth(width: CGFloat) {
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func alignHeight(height: CGFloat) {
    self.heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func alignHeightWithMultiplier(toView: UIView, multipler: CGFloat) {
    self.heightAnchor.constraint(equalTo: toView.heightAnchor, multiplier: multipler).isActive = true
  }
  
}
