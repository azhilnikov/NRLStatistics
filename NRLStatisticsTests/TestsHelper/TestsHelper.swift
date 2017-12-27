//
//  TestsHelper.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import Foundation

class TestsHelper {
  
  class func loadJSON(from fileName: String) -> Data? {
    guard let url = Bundle(for: TestsHelper.self).url(forResource: fileName, withExtension: "json") else {
      return nil
    }
    
    guard let data = try? Data(contentsOf: url) else { return nil }
    return data
  }
}
