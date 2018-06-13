//
//  ColorModel.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 12/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import Foundation

struct ColorModel {
  var r1: Int!
  var r2: Int!
  var g1: Int!
  var g2: Int!
  var b1: Int!
  var b2: Int!
  
  func getRGBString(single: Bool) -> String {
    if single {
      return "\(r1),\(g1),\(b1),\(r1),\(g1),\(b1)"
    }
    else {
      return "\(r1),\(g1),\(b1),\(r2),\(g2),\(b2)"
    }
  }
  
}
