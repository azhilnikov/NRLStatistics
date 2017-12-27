//
//  TopPlayersViewController.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class TopPlayersViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  
  var viewModel: TopPlayersViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareNavigationController()
    prepareTableView()
  }
  
  private func prepareNavigationController() {
    navigationItem.title = viewModel.title
  }
  
  private func prepareTableView() {
    tableView.registerNibForHeaderFooterView(TopPlayersTableViewSectionHeader.self)
    tableView.estimatedSectionHeaderHeight = TopPlayersTableViewSectionHeader.height
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    
    tableView.registerNib(TopPlayersTableViewCell.self)
    tableView.estimatedRowHeight = TopPlayersTableViewCell.height
    tableView.rowHeight = UITableViewAutomaticDimension
  }
}

extension TopPlayersViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(type: TopPlayersTableViewCell.self, forIndexPath: indexPath)
    
    let teamAPlayerCellViewModel = viewModel.playerCellViewModel(for: .teamA, at: indexPath.row)
    let teamBPlayerCellViewModel = viewModel.playerCellViewModel(for: .teamB, at: indexPath.row)
    
    cell.bind(teamATopPlayer: teamAPlayerCellViewModel,
              teamBTopPlayer: teamBPlayerCellViewModel,
              cellIndex: indexPath.row)
    
    cell.playerTap = viewModel.selectPlayer
    return cell
  }
}

extension TopPlayersViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueHeaderFooterView(TopPlayersTableViewSectionHeader.self)
    headerView.bind(teamA: viewModel.teamName(for: .teamA), teamB: viewModel.teamName(for: .teamB))
    return headerView
  }
}

extension TopPlayersViewController: TopPlayersViewControllerProtocol {
  
  func showPlayer(playerId: Int, teamId: Int) {
    let storyboard = UIStoryboard(name: "Player", bundle: nil)
    let identifier = String(describing: PlayerViewController.self)
    
    if let playerViewController =
      storyboard.instantiateViewController(withIdentifier: identifier) as? PlayerViewController {
      
      let playerViewModel = PlayerViewModel(viewController: playerViewController,
                                            playerId: playerId,
                                            teamId: teamId)
      
      playerViewController.viewModel = playerViewModel
      
      let navigationController = UINavigationController(rootViewController: playerViewController)
      present(navigationController, animated: true)
    }
  }
}
