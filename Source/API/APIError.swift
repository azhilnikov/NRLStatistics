//
//  APIError.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

enum APIError: Error {
  case noInternetConnection
  case invalidURL
  case invalidResponse
  case invalidStatusCode
  case invalidData
  case invalidJSONFormat
}

extension APIError: LocalizedError {
  
  var errorDescription: String? {
    
    switch self {
    case .noInternetConnection:
      return NSLocalizedString("No Internet connection", comment: "")
      
    case .invalidURL:
      return NSLocalizedString("Invalid URL", comment: "")
      
    case .invalidResponse:
      return NSLocalizedString("Invalid Response", comment: "")
      
    case .invalidStatusCode:
      return NSLocalizedString("Invalid status code", comment: "")
      
    case .invalidData:
      return NSLocalizedString("Invalid data", comment: "")
      
    case .invalidJSONFormat:
      return NSLocalizedString("Invalid JSON format", comment: "")
    }
  }
}
