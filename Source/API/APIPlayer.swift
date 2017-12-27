//
//  APIPlayer.swift
//  NRLStatistics
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class APIPlayer {
  
  private let playerId: Int
  private let teamId: Int
  private var urlComponents = URLComponents()
  private let apiRequest = APIRequest()
  
  init(playerId: Int, teamId: Int) {
    self.playerId = playerId
    self.teamId = teamId
  }
  
  func fetch(completion: @escaping (APIResult) -> Void) {
    urlComponents.scheme = scheme
    urlComponents.host = host
    urlComponents.path = path
    urlComponents.queryItems = queryItems
    
    guard let url = url else {
      completion(.failure(APIError.invalidURL))
      return
    }
    
    apiRequest.fetch(url: url) { (result) in
      
      switch result {
      case .success(let data):
        completion(.success(data))
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}

extension APIPlayer: APIProtocol {
  
  var scheme: String? {
    return "https"
  }
  
  var host: String? {
    return "statsapi.foxsports.com.au"
  }
  
  var path: String {
    return "/3.0/api/sports/league/series/1/seasons/115/teams/\(teamId)/players/\(playerId)/detailedstats.json"
  }
  
  var queryItems: [URLQueryItem]? {
    let userKeyQuery = URLQueryItem(name: "userkey", value: "9024ec15-d791-4bfd-aa3b-5bcf5d36da4f")
    return [userKeyQuery]
  }
  
  var url: URL? {
    return urlComponents.url
  }
}
