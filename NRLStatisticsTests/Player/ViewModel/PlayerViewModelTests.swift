//
//  PlayerViewModelTests.swift
//  NRLStatisticsTests
//
//  Created by Alexey on 27/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import NRLStatistics

class PlayerViewModelTests: XCTestCase {
  
  private var viewControllerMock: PlayerViewControllerMock!
  private var sut: PlayerViewModel!
  private var player: Player!
  
  override func setUp() {
    super.setUp()
    
    let jsonData = TestsHelper.loadJSON(from: "Player")!
    
    let decoder = JSONDecoder()
    player = try! decoder.decode(Player.self, from: jsonData)
    
    viewControllerMock = PlayerViewControllerMock()
    sut = PlayerViewModel(viewController: viewControllerMock,
                          playerId: 115370,
                          teamId: 5501,
                          player: player)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testTitle() {
    let title = sut.title
    XCTAssertEqual(title!, "Dylan Edwards")
  }
  
  func testDateOfBirth() {
    XCTAssertEqual(sut.dateOfBirth!, "1996-01-10")
  }
  
  func testHeight() {
    XCTAssertEqual(sut.height!, "183")
  }
  
  func testWeight() {
    XCTAssertEqual(sut.weight!, "93")
  }
  
  func testPosition() {
    XCTAssertEqual(sut.position!, "Fullback")
  }
  
  func testLastMatchErrors() {
    XCTAssertEqual(sut.lastMatchErrors!, "01")
  }
  
  func testLastMatchGoals() {
    XCTAssertEqual(sut.lastMatchGoals!, "00")
  }
  
  func testLastMatchPoints() {
    XCTAssertEqual(sut.lastMatchPoints!, "00")
  }
  
  func testLastMatchRuns() {
    XCTAssertEqual(sut.lastMatchRuns!, "20")
  }
  
  func testLastMatchTackles() {
    XCTAssertEqual(sut.lastMatchTackles!, "08")
  }
  
  func testLastMatchTries() {
    XCTAssertEqual(sut.lastMatchTries!, "00")
  }
  
  func testLastMatchMinsPlayed() {
    XCTAssertEqual(sut.lastMatchMinsPlayed!, "80")
  }
  
  func testLastMatchRunMetres() {
    XCTAssertEqual(sut.lastMatchRunMetres!, "156")
  }
}

class PlayerViewControllerMock: PlayerViewControllerProtocol {
  
  func showError(_ message: String) {
  }
  
  func reloadData() {
  }
}
