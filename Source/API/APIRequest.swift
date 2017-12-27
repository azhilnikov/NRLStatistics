//
//  APIRequest.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

protocol APIProtocol {
  var scheme: String? { get }
  var host: String? { get }
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
  var url: URL? { get }
}

enum APIResult {
  case success(Data)
  case failure(Error)
}

class APIRequest {
  
  func fetch(url: URL, completion: @escaping (APIResult) -> Void) {
    
    if !APIReachability.isInternetConnectionAvailable {
      completion(.failure(APIError.noInternetConnection))
      return
    }
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    let request = URLRequest(url: url,
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 10)
    
    let session = URLSession(configuration: .default)
    session.dataTask(with: request) { (data, response, error) in
      
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if let error = error {
          completion(.failure(error))
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          completion(.failure(APIError.invalidResponse))
          return
        }
        
        if 200 != response.statusCode {
          completion(.failure(APIError.invalidStatusCode))
        }
        
        guard let responseData = data else {
          completion(.failure(APIError.invalidData))
          return
        }
        
        completion(.success(responseData))
      }
    }.resume()
  }
}
