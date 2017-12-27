//
//  Statistics.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct Statistics: Codable {
  
  let matchId: String
  let teamA: Team
  let teamB: Team
  let statsType: String
  
  private enum CodingKeys: String, CodingKey {
    case matchId = "match_id"
    case teamA = "team_A"
    case teamB = "team_B"
    case statsType = "stat_type"
  }
}
