//
//  DoubleViewController.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit
import ChromaColorPicker
import SwiftMQTT

class DoubleViewController: UIViewController {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var chromaView: ChromaColorPicker!
  @IBOutlet weak var segmentedController: UISegmentedControl!
  
  var mqttSession: MQTTSession!
  var color1: UIColor!
  var color2: UIColor!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButton()
    setupChromaView()
    addNavBarIcon()
    containerView.backgroundColor = .clear
    segmentedController.tintColor = Constants.Colors.primaryColor
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupMqtt()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    mqttSession.disconnect()
  }
  
  func addNavBarIcon() {
    let infoButton = UIButton(type: .infoLight)
    infoButton.tintColor = .white
    infoButton.addTarget(self, action: #selector(navbarButtonTapped), for: .touchUpInside)
    let barButtonItem = UIBarButtonItem(customView: infoButton)
    navigationItem.rightBarButtonItem = barButtonItem
  }
  
  @objc func navbarButtonTapped() {
    performSegue(withIdentifier: "showInfo", sender: self)
  }
  
  @objc func doneButtonTapped() {
    if let color1 = color1 {
      if let color2 = color2 {
        publishMessage(messageString: getRGB(color1: color1, color2: color2, single: false))
      }
      else {
        showBanner(title: "Invalid", subtitle: "Choose Color 2", color: Constants.Colors.errorColor)
      }
    }
    else {
      showBanner(title: "Invalid", subtitle: "Choose Color 1", color: Constants.Colors.errorColor)
    }
  }
  
  func setupButton() {
    doneButton.applyButtonStyling()
    doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
  }
  
  func setupChromaView() {
    chromaView.delegate = self
    chromaView.padding = 5
    chromaView.stroke = 3
    chromaView.hexLabel.isHidden = true
    chromaView.layout()
  }
  
}

//MARK:- MQTT Methods
extension DoubleViewController: MQTTSessionDelegate {
  
  func setupMqtt() {
    mqttSession = MQTTSession(host: Constants.MQTT.host, port: Constants.MQTT.port, clientID: Constants.MQTT.clientID, cleanSession: true, keepAlive: 60, useSSL: false)
    mqttSession.delegate = self
    mqttSession.connect { (success, error) in
      if success {
        print("Connected")
      }
      else {
        print("\(error.localizedDescription)")
        self.showBanner(title: "Invalid", subtitle: "Problem Connecting. Try again later.", color: Constants.Colors.errorColor)
      }
    }
  }
  
  func publishMessage(messageString: String) {
    let data = messageString.data(using: .utf8)
    mqttSession.publish(data!, in: Constants.MQTT.topic, delivering: .atLeastOnce, retain: false) { (success, error) in
      if success {
        print("Successfully published")
      }
      else {
        print("\(error.localizedDescription)")
        self.showBanner(title: "Invalid", subtitle: "Problem Publishing. Try again later.", color: Constants.Colors.errorColor)

      }
    }
  }
  
  func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
    print("Message received")
  }
  
  func mqttDidDisconnect(session: MQTTSession) {
    print("Mqtt disconnected")
  }
  
  func mqttSocketErrorOccurred(session: MQTTSession) {
    print("Mqtt socket error")
  }
}


extension DoubleViewController: ChromaColorPickerDelegate {
  
  func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
    if segmentedController.selectedSegmentIndex == 0 {
      color1 = color
    }
    else {
      color2 = color
    }
  }
}
