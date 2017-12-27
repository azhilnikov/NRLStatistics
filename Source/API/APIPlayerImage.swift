//
//  APIPlayerImage.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class APIPlayerImage {
  
  private let apiRequest = APIRequest()
  private var urlComponents = URLComponents()
  private let playerId: Int
  
  init(playerId: Int) {
    self.playerId = playerId
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

extension APIPlayerImage: APIProtocol {
  
  var scheme: String? {
    return "http"
  }
  
  var host: String? {
    return "media.foxsports.com.au"
  }
  
  var path: String {
    return "/match-centre/includes/images/headshots/landscape/nrl/\(playerId).jpg"
  }
  
  var queryItems: [URLQueryItem]? {
    return nil
  }
  
  var url: URL? {
    return urlComponents.url
  }
}
