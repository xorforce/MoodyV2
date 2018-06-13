//
//  Constants.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 11/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit
import Hue
import SwiftMQTT

struct Constants {
  struct Colors {
    static let primaryColor = UIColor(hex: "#FFCC33")
    static let errorColor = UIColor(hex: "#C3423F")
    static let successColor = UIColor(hex: "#9BC53D")
  }
  
  struct MQTT {
    static let clientID = "Moody-" + String(ProcessInfo().processIdentifier)
    static let host = "iot.eclipse.org"
    static let port: UInt16 = 1883
    static let topic = "moody/testdev/set"
  }
  
  struct Messages {
    static let successTitle = "Success!"
    static let errorTitle = "Failed!"
    static let colorSetSuccess = "The colors have been set!"
    static let colorSetError = "The colors did not set. Try again later!"
  }
  
}
