//
//  StatisticsViewModelTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class StatisticsViewModelTests: XCTestCase {
  
  private var viewControllerMock: StatisticsViewControllerMock!
  private var sut: StatisticsViewModel!
  private var statistics: [Statistics]!
  
  override func setUp() {
    super.setUp()
    
    let jsonData = TestsHelper.loadJSON(from: "Statistics")!
    
    let decoder = JSONDecoder()
    statistics = try! decoder.decode([Statistics].self, from: jsonData)
    
    viewControllerMock = StatisticsViewControllerMock()
    sut = StatisticsViewModel(viewController: viewControllerMock, statistics: statistics)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testNumberOfSections() {
    let numberOfSections = sut.numberOfSections
    XCTAssertEqual(numberOfSections, statistics.count)
  }
  
  func testHeaderTitle() {
    var title = sut.headerTitle(at: 0)
    XCTAssertNotNil(title)
    XCTAssertEqual(title!, "Runs")
    
    title = sut.headerTitle(at: 1)
    XCTAssertNotNil(title)
    XCTAssertEqual(title!, "Tackles")
    
    title = sut.headerTitle(at: 2)
    XCTAssertNotNil(title)
    XCTAssertEqual(title!, "Fantasy Points")
    
    title = sut.headerTitle(at: 3)
    XCTAssertNotNil(title)
    XCTAssertEqual(title!, "Run Metres")
  }
  
  func testTeamName() {
    let teamAName = sut.teamName(for: .teamA, at: 1)
    XCTAssertEqual(teamAName, "Panthers")
    
    let teamBName = sut.teamName(for: .teamB, at: 3)
    XCTAssertEqual(teamBName, "Bulldogs")
  }
  
  func testShowTopPlayers() {
    sut.selectStatistics(at: 0)
    XCTAssertTrue(viewControllerMock.isShowTopPlayersCalled)
  }
}

class StatisticsViewControllerMock: StatisticsViewControllerProtocol {
  
  private(set) var isShowTopPlayersCalled = false
  
  func showError(_ message: String) {
  }
  
  func reloadData() {
  }
  
  func showTopPlayers(statistics: Statistics) {
    isShowTopPlayersCalled = true
  }
}
