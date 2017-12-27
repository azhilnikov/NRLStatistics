//
//  TopPlayer.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct TopPlayer: Codable {
  
  let id: Int
  let position: String
  let fullName: String
  let shortName: String
  let statValue: Int
  let jumperNumber: Int
  
  private enum CodingKeys: String, CodingKey {
    case id
    case position
    case fullName = "full_name"
    case shortName = "short_name"
    case statValue = "stat_value"
    case jumperNumber = "jumper_number"
  }
}
