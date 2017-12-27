//
//  APIPlayerTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class APIPlayerTest: XCTestCase {
  
  func testAPIPlayerPath() {
    let apiPlayer = APIPlayer(playerId: 12345, teamId: 7890)
    XCTAssertEqual(apiPlayer.path,
                   "/3.0/api/sports/league/series/1/seasons/115/teams/7890/players/12345/detailedstats.json")
  }
}
