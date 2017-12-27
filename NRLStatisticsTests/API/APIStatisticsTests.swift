//
//  APIStatisticsTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class APIStatisticsTests: XCTestCase {
  
  func testAPIStatisticsPath() {
    let apiStatistics = APIStatistics(statisticsTypes: [.fantasyPoints, .runMetres, .runs, .tackles])
    XCTAssertEqual(apiStatistics.path,
                   "/3.0/api/sports/league/matches/NRL20172101/topplayerstats.json;type=fantasy_points;type=run_metres;type=runs;type=tackles")
  }
}
