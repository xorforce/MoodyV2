//
//  RandomViewController.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit
import SwiftMQTT

class RandomViewController: UIViewController {

  @IBOutlet weak var randomButton: UIButton!
  
  var mqttSession: MQTTSession!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRandomButton()
    print(getRandomColor())
    addNavBarIcon()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setupMqtt()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    mqttSession.disconnect()
  }
  
  func setupRandomButton() {
    randomButton.applyButtonStyling()
    randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
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
  
  @objc func randomButtonPressed() {
    print("Done Button")
    publishMessage(messageString: getRandomColor())
  }
}

extension RandomViewController: MQTTSessionDelegate {
  
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

