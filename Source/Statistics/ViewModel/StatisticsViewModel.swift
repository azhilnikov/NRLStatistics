//
//  StatisticsViewModel.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

protocol StatisticsViewControllerProtocol: class {
  func showError(_ message: String)
  func reloadData()
  func showTopPlayers(statistics: Statistics)
}

class StatisticsViewModel {
  
  private unowned let viewController: StatisticsViewControllerProtocol
  private var statistics: [Statistics]
  private let apiStatistics: APIStatistics
  
  var numberOfSections: Int {
    return statistics.count
  }
  
  init(viewController: StatisticsViewControllerProtocol,
       statistics: [Statistics] = [],
       apiStatistics: APIStatistics = APIStatistics(statisticsTypes: [.fantasyPoints, .runMetres, .runs, .tackles])) {
    self.viewController = viewController
    self.statistics = statistics
    self.apiStatistics = apiStatistics
  }
  
  func fetchStatistics() {
    apiStatistics.fetch() { [weak self] (result) in
      
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        guard let stats = try? decoder.decode([Statistics].self, from: data) else {
          self?.viewController.showError(APIError.invalidJSONFormat.localizedDescription)
          return
        }
        self?.statistics = stats
        self?.viewController.reloadData()
        
      case .failure(let error):
        self?.viewController.showError(error.localizedDescription)
      }
    }
  }
  
  func headerTitle(at index: Int) -> String? {
    if let statsType = StatisticsType(rawValue: statistics[index].statsType) {
      return statsType.displayName
    }
    return nil
  }
  
  func teamName(for team: TeamType, at index: Int) -> String {
    
    switch team {
    case .teamA:
      return statistics[index].teamA.shortName
      
    case .teamB:
      return statistics[index].teamB.shortName
    }
  }
  
  func selectStatistics(at index: Int) {
    viewController.showTopPlayers(statistics: statistics[index])
  }
}
