//
//  TopPlayersTableViewCellViewModel.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class TopPlayersTableViewCellViewModel {
  
  private let topPlayer: TopPlayer
  
  var shortName: String {
    return topPlayer.shortName
  }
  
  var postition: String {
    return topPlayer.position
  }
  
  var jumperNumber: String {
    return "\(topPlayer.jumperNumber)"
  }
  
  init(topPlayer: TopPlayer) {
    self.topPlayer = topPlayer
  }
  
  func image(completion: @escaping (UIImage) -> Void) {
    let apiPlayerImage = APIPlayerImage(playerId: topPlayer.id)
    
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
}
