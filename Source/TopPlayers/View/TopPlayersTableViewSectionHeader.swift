//
//  TopPlayersTableViewSectionHeader.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class TopPlayersTableViewSectionHeader: UITableViewHeaderFooterView {
  
  @IBOutlet private weak var teamANameLabel: UILabel!
  @IBOutlet private weak var teamBNameLabel: UILabel!
  
  static let height: CGFloat = 56
  
  func bind(teamA: String, teamB: String) {
    teamANameLabel.text = teamA
    teamBNameLabel.text = teamB
  }
}
