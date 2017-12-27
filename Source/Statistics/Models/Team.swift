//
//  Team.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum TeamType {
  case teamA
  case teamB
}

struct Team: Codable {
  
  let id: Int
  let name: String
  let code: String
  let shortName: String
  let topPlayers: [TopPlayer]
  
  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case code
    case shortName = "short_name"
    case topPlayers = "top_players"
  }
}
