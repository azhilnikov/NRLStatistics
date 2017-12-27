//
//  TopPlayerViewModelTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class TopPlayersViewModelTests: XCTestCase {
  
  private var viewControllerMock: TopPlayersViewControllerMock!
  private var sut: TopPlayersViewModel!
  private var statistics: Statistics!
  
  override func setUp() {
    super.setUp()
    
    let jsonData = TestsHelper.loadJSON(from: "Statistics")!
    
    let decoder = JSONDecoder()
    let statisticsArray = try! decoder.decode([Statistics].self, from: jsonData)
    statistics = statisticsArray.first!
    
    viewControllerMock = TopPlayersViewControllerMock()
    sut = TopPlayersViewModel(viewController: viewControllerMock, statistics: statistics)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testTitle() {
    let title = sut.title
    XCTAssertNotNil(title)
    XCTAssertEqual(title, "Runs")
  }
  
  func testNumberOfRows() {
    let numberOfRows = sut.numberOfRows
    XCTAssertEqual(numberOfRows, min(statistics.teamA.topPlayers.count,
                                     statistics.teamB.topPlayers.count))
  }
  
  func testTeamName() {
    let teamAName = sut.teamName(for: .teamA)
    XCTAssertEqual(teamAName, "Panthers")
    
    let teamBName = sut.teamName(for: .teamB)
    XCTAssertEqual(teamBName, "Bulldogs")
  }
  
  func testSelectPlayer() {
    sut.selectPlayer(.teamA, nil)
    XCTAssertFalse(viewControllerMock.isShowPlayerCalled)
    
    sut.selectPlayer(.teamB, nil)
    XCTAssertFalse(viewControllerMock.isShowPlayerCalled)
  }
  
  func testSelectPlayerFromTeamA() {
    sut.selectPlayer(.teamA, 1)
    XCTAssertTrue(viewControllerMock.isShowPlayerCalled)
  }
  
  func testSelectPlayerFromTeamB() {
    sut.selectPlayer(.teamB, 1)
    XCTAssertTrue(viewControllerMock.isShowPlayerCalled)
  }
}

class TopPlayersViewControllerMock: TopPlayersViewControllerProtocol {
  
  private(set) var isShowPlayerCalled = false
  
  func showPlayer(playerId: Int, teamId: Int) {
    isShowPlayerCalled = true
  }
}
