//
//  TopPlayersViewModel.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol TopPlayersViewControllerProtocol: class {
  func showPlayer(playerId: Int, teamId: Int)
}

class TopPlayersViewModel {
  
  unowned private let viewController: TopPlayersViewControllerProtocol
  private let statistics: Statistics
  
  var title: String? {
    let statsType = StatisticsType(rawValue: statistics.statsType)
    return statsType?.displayName
  }
  
  var numberOfRows: Int {
    return min(statistics.teamA.topPlayers.count, statistics.teamB.topPlayers.count)
  }
  
  init(viewController: TopPlayersViewControllerProtocol, statistics: Statistics) {
    self.viewController = viewController
    self.statistics = statistics
  }
  
  func teamName(for team: TeamType) -> String {
    
    switch team {
    case .teamA:
      return statistics.teamA.shortName
      
    case .teamB:
      return statistics.teamB.shortName
    }
  }
  
  func playerCellViewModel(for team: TeamType, at index: Int) -> TopPlayersTableViewCellViewModel {
    
    switch team {
    case .teamA:
      return TopPlayersTableViewCellViewModel(topPlayer: statistics.teamA.topPlayers[index])
      
    case .teamB:
      return TopPlayersTableViewCellViewModel(topPlayer: statistics.teamB.topPlayers[index])
    }
  }
  
  func selectPlayer(_ teamType: TeamType, _ index: Int?) {
    guard let index = index else { return }
    
    switch teamType {
    case .teamA:
      viewController.showPlayer(playerId: statistics.teamA.topPlayers[index].id,
                                teamId: statistics.teamA.id)
      
    case .teamB:
      viewController.showPlayer(playerId: statistics.teamB.topPlayers[index].id,
                                teamId: statistics.teamB.id)
    }
  }
}
