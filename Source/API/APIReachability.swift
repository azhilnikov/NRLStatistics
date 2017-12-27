//
//  APIReachability.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import SystemConfiguration

class APIReachability {
  
  static var isInternetConnectionAvailable: Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
        SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
      }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
      return false
    }
    
    let isReachable = 0 != (flags.rawValue & UInt32(kSCNetworkFlagsReachable))
    let needsConnection = 0 != (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired))
    return isReachable && !needsConnection
  }
}
