//
//  SingleViewController.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit
import ChromaColorPicker
import SwiftMQTT

class SingleViewController: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var doneButton: UIButton!
  @IBOutlet weak var chromaView: ChromaColorPicker!
  
  var mqttSession: MQTTSession!
  var colorString: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButton()
    addNavBarIcon()
    setupChromaView()
    containerView.backgroundColor = .clear
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupMqtt()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    mqttSession.disconnect()
  }
  
  @objc func doneButtonTapped() {
    if let stringToPublish = colorString {
      publishMessage(messageString: stringToPublish)
    }
    else {
      //show drop down
      self.showBanner(title: "Invalid", subtitle: "Select Color", color: Constants.Colors.errorColor)
    }
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
  
}

//MARK:- MQTT Methods
extension SingleViewController: MQTTSessionDelegate {
  func mqttDidReceive(message data: Data, in topic: String, from session: MQTTSession) {
    print("Message received")
  }
  
  func mqttDidDisconnect(session: MQTTSession) {
    print("Mqtt disconnected")
  }
  
  func mqttSocketErrorOccurred(session: MQTTSession) {
    print("Mqtt socket error")
  }
  
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
}

//MARK:- ChromaColorPicker Delegate
extension SingleViewController: ChromaColorPickerDelegate {
  
  func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
    colorString = getRGB(color1: color, color2: nil, single: true)
  }
}

//MARK:- UI Setup
extension SingleViewController {
  
  func setupButton() {
    doneButton.applyButtonStyling()
    doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
  }
  
  func setupChromaView() {
    chromaView.delegate = self
    chromaView.padding = 5
    chromaView.stroke = 3
    chromaView.hexLabel.textColor = .white
    chromaView.layout()
  }
  
}

