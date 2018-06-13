//
//  BaseViewController.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit
import ChromaColorPicker

class BaseViewController: UIViewController {

  let sidePadding: CGFloat = 20
  let verticalPadding: CGFloat = 20
  var navBarHeight: CGFloat?
  
  let containerView: UIView = {
    let cv = UIView()
    cv.backgroundColor = .gray
    return cv
  }()
  
  let doneButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Done", for: .normal)
    button.layer.cornerRadius = 15.0
    button.layer.borderWidth = 1.2
    button.layer.borderColor = UIColor.blue.cgColor
    return button
  }()
  
  let chromaView = ChromaColorPicker(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 11.0, *) {
      navigationController?.navigationBar.prefersLargeTitles = true
    } else {
      // Fallback on earlier versions
      
    }
  }
  
  func addContainerView() {
    view.addSubview(containerView)
    containerView.prepareForAutoLayout()
    containerView.centreX(to: view)
    containerView.alignTop(to: view, padding: navBarHeight! + 20)
    containerView.alignLeft(to: view, padding: sidePadding)
    containerView.alignRight(to: view, padding: sidePadding)
    containerView.alignHeightWithMultiplier(toView: view, multipler: 0.8)
  }
  
  func addChromaView() {
    view.addSubview(chromaView)
    chromaView.prepareForAutoLayout()
    chromaView.centreX(to: view)
    chromaView.alignTop(to: view, padding: verticalPadding)
    chromaView.alignWidth(width: 250)
    chromaView.alignHeight(height: 250)
    chromaView.layout()
  }
  
  func addDoneButton() {
    view.addSubview(doneButton)
    doneButton.prepareForAutoLayout()
    doneButton.centreX(to: view)
    doneButton.setBelow(to: view, padding: 8)
    doneButton.alignHeight(height: 40)
    doneButton.alignWidth(width: 150)
  }
  
  
  
}
