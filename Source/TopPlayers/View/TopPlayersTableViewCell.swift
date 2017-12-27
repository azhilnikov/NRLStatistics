//
//  TopPlayersTableViewCell.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class TopPlayersTableViewCell: UITableViewCell {

  @IBOutlet private weak var teamAView: UIView!
  @IBOutlet private weak var teamAPlayerImageView: UIImageView!
  @IBOutlet private weak var teamAPlayerNameLabel: UILabel!
  @IBOutlet private weak var teamAPlayerPositionNumberLabel: UILabel!
  
  @IBOutlet private weak var teamBView: UIView!
  @IBOutlet private weak var teamBPlayerImageView: UIImageView!
  @IBOutlet private weak var teamBPlayerNameLabel: UILabel!
  @IBOutlet private weak var teamBPlayerPositionNumberLabel: UILabel!
  
  static let height: CGFloat = 135
  
  private var cellIndex: Int?
  
  var playerTap: ((TeamType, Int?) -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    prepareUI()
  }

  func bind(teamATopPlayer: TopPlayersTableViewCellViewModel,
            teamBTopPlayer: TopPlayersTableViewCellViewModel,
            cellIndex: Int) {
    
    self.cellIndex = cellIndex
    
    teamATopPlayer.image() { [weak self] (playerImage) in
      self?.teamAPlayerImageView.image = playerImage
    }
    teamAPlayerNameLabel.text = teamATopPlayer.shortName
    teamAPlayerPositionNumberLabel.text = "\(teamATopPlayer.postition), \(teamATopPlayer.jumperNumber)"
    
    teamBTopPlayer.image() { [weak self] (playerImage) in
      self?.teamBPlayerImageView.image = playerImage
    }
    teamBPlayerNameLabel.text = teamBTopPlayer.shortName
    teamBPlayerPositionNumberLabel.text = "\(teamBTopPlayer.postition), \(teamBTopPlayer.jumperNumber)"
  }
  
  private func prepareUI() {
    let playerATap = UITapGestureRecognizer(target: self, action: #selector(playerATapAction))
    teamAView.addGestureRecognizer(playerATap)
    
    let playerBTap = UITapGestureRecognizer(target: self, action: #selector(playerBTapAction))
    teamBView.addGestureRecognizer(playerBTap)
  }
  
  @objc private func playerATapAction() {
    playerTap?(.teamA, cellIndex)
  }
  
  @objc private func playerBTapAction() {
    playerTap?(.teamB, cellIndex)
  }
}
