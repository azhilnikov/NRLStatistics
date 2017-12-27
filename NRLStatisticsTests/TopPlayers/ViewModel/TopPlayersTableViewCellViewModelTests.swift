//
//  TopPlayersTableViewCellViewModelTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class TopPlayersTableViewCellViewModelTests: XCTestCase {
  
  private var sut: TopPlayersTableViewCellViewModel!
  private var topPlayer: TopPlayer!
  
  override func setUp() {
    super.setUp()
    
    let jsonData = TestsHelper.loadJSON(from: "Statistics")!
    
    let decoder = JSONDecoder()
    let statistics = try! decoder.decode([Statistics].self, from: jsonData).first!
    
    topPlayer = statistics.teamA.topPlayers[1]
    sut = TopPlayersTableViewCellViewModel(topPlayer: topPlayer)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testShortName() {
    let shortName = sut.shortName
    XCTAssertEqual(shortName, "J. Tamou")
  }
  
  func testPostition() {
    let position = sut.postition
    XCTAssertEqual(position, "Prop Forward")
  }
  
  func testJumperNumber() {
    let jumperNumber = sut.jumperNumber
    XCTAssertEqual(jumperNumber, "8")
  }
}
