//
//  APIPlayerImageTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class APIPlayerImageTests: XCTestCase {
  
  func testAPIPlayerImagePath() {
    let apiPlayerImage = APIPlayerImage(playerId: 35598)
    XCTAssertEqual(apiPlayerImage.path,
                   "/match-centre/includes/images/headshots/landscape/nrl/35598.jpg")
  }
}
