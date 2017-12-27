//
//  APIStatistics.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class APIStatistics {
  
  private let apiRequest = APIRequest()
  private var urlComponents = URLComponents()
  private let statisticsTypes: [StatisticsType]
  
  init(statisticsTypes: [StatisticsType]) {
    self.statisticsTypes = statisticsTypes
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

extension APIStatistics: APIProtocol {
  
  var scheme: String? {
    return "https"
  }
  
  var host: String? {
    return "statsapi.foxsports.com.au"
  }
  
  var path: String {
    let types = statisticsTypes.map { ";type=" + $0.rawValue }.joined()
    return "/3.0/api/sports/league/matches/NRL20172101/topplayerstats.json" + types
  }
  
  var queryItems: [URLQueryItem]? {
    let limitQuery = URLQueryItem(name: "limit", value: "5")
    let userKeyQuery = URLQueryItem(name: "userkey", value: "A00239D3-45F6-4A0A-810C-54A347F144C2")
    return [limitQuery, userKeyQuery]
  }
  
  var url: URL? {
    guard let absoluteURLString = urlComponents.url?.absoluteString.removingPercentEncoding,
      let url = URL(string: absoluteURLString) else {
        return nil
    }
    return url
  }
}
