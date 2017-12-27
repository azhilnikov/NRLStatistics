//
//  StatisticsType.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum StatisticsType: String {
  
  var displayName: String {
    
    switch self {
    case .fantasyPoints:
      return "Fantasy Points"
    
    case .runMetres:
      return "Run Metres"
      
    case .runs:
      return "Runs"
      
    case .tackles:
      return "Tackles"
    }
  }
  
  case fantasyPoints = "fantasy_points"
  case runMetres = "run_metres"
  case runs = "runs"
  case tackles = "tackles"
}
