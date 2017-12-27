//
//  LastMatchStatistics.swift
//  NRLStatistics
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

struct LastMatchStatistics: Codable {
  
  let errors: Int
  let goals: Int
  let points: Int
  let runs: Int
  let tackles: Int
  let tries: Int
  let minsPlayed: Int
  let runMetres: Int
  
  private enum CodingKeys: String, CodingKey {
    case errors
    case goals
    case points
    case runs
    case tackles
    case tries
    case minsPlayed = "mins_played"
    case runMetres = "run_metres"
  }
}
