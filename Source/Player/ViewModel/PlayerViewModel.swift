//
//  PlayerViewModel.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

protocol PlayerViewControllerProtocol: class {
  func showError(_ message: String)
  func reloadData()
}

class PlayerViewModel {
  
  unowned private let viewController: PlayerViewControllerProtocol
  private let playerId: Int
  private let teamId: Int
  private var player: Player?
  
  var title: String? {
    return player?.fullName
  }
  
  var dateOfBirth: String? {
    return player?.dateOfBirth
  }
  
  var height: String? {
    guard let player = player else { return nil }
    return "\(player.height)"
  }
  
  var weight: String? {
    guard let player = player else { return nil }
    return "\(player.weight)"
  }
  
  var position: String? {
    return player?.position
  }
  
  var lastMatchErrors: String? {
    guard let errors = player?.lastMatchStatistics.errors else { return nil }
    return String(format: "%02d", errors)
  }
  
  var lastMatchGoals: String? {
    guard let goals = player?.lastMatchStatistics.goals else { return nil }
    return String(format: "%02d", goals)
  }
  
  var lastMatchPoints: String? {
    guard let points = player?.lastMatchStatistics.points else { return nil }
    return String(format: "%02d", points)
  }
  
  var lastMatchRuns: String? {
    guard let runs = player?.lastMatchStatistics.runs else { return nil }
    return String(format: "%02d", runs)
  }
  
  var lastMatchTackles: String? {
    guard let tackles = player?.lastMatchStatistics.tackles else { return nil }
    return String(format: "%02d", tackles)
  }
  
  var lastMatchTries: String? {
    guard let tries = player?.lastMatchStatistics.tries else { return nil }
    return String(format: "%02d", tries)
  }
  
  var lastMatchMinsPlayed: String? {
    guard let minsPlayed = player?.lastMatchStatistics.minsPlayed else { return nil }
    return String(format: "%02d", minsPlayed)
  }
  
  var lastMatchRunMetres: String? {
    guard let runMetres = player?.lastMatchStatistics.runMetres else { return nil }
    return String(format: "%02d", runMetres)
  }
  
  init(viewController: PlayerViewControllerProtocol,
       playerId: Int,
       teamId: Int,
       player: Player? = nil) {
    self.viewController = viewController
    self.playerId = playerId
    self.teamId = teamId
    self.player = player
  }
  
  func playerImage(completion: @escaping (UIImage) -> Void) {
    let apiPlayerImage = APIPlayerImage(playerId: playerId)
    
    apiPlayerImage.fetch() { (result) in
      
      switch result {
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(image)
        }
        
      case .failure(_):
        break
      }
    }
  }
  
  func fetchPlayer() {
    
    let apiPlayer = APIPlayer(playerId: playerId, teamId: teamId)
    
    apiPlayer.fetch() { [weak self] result in
      
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        guard let player = try? decoder.decode(Player.self, from: data) else {
          self?.viewController.showError(APIError.invalidJSONFormat.localizedDescription)
          return
        }
        
        self?.player = player
        self?.viewController.reloadData()
        
      case .failure(let error):
        self?.viewController.showError(error.localizedDescription)
      }
    }
  }
}
