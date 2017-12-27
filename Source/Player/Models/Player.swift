//
//  Player.swift
//  NRLStatistics
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct Player: Codable {
  
  let id: Int
  let position: String
  let fullName: String
  let dateOfBirth: String
  let height: Int
  let weight: Int
  let lastMatchStatistics: LastMatchStatistics
  
  private enum CodingKeys: String, CodingKey {
    case id
    case position
    case fullName = "full_name"
    case dateOfBirth = "date_of_birth"
    case height = "height_cm"
    case weight = "weight_kg"
    case lastMatchStatistics = "last_match_stats"
  }
}
