//
//  StatisticsViewController.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!
  
  lazy private var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self,
                             action: #selector(refreshTableView),
                             for: .valueChanged)
    return refreshControl
  }()
  lazy private var viewModel = StatisticsViewModel(viewController: self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareTableView()
    viewModel.fetchStatistics()
  }
  
  private func prepareTableView() {
    tableView.tableFooterView = UIView()
    tableView.registerNib(StatisticsTableViewCell.self)
    tableView.estimatedRowHeight = StatisticsTableViewCell.height
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.addSubview(refreshControl)
  }
  
  @objc private func refreshTableView() {
    viewModel.fetchStatistics()
  }
}

extension StatisticsViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(type: StatisticsTableViewCell.self, forIndexPath: indexPath)
    cell.bind(teamA: viewModel.teamName(for: .teamA, at: indexPath.section),
              teamB: viewModel.teamName(for: .teamB, at: indexPath.section))
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.headerTitle(at: section)
  }
}

extension StatisticsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectStatistics(at: indexPath.section)
  }
}

extension StatisticsViewController: StatisticsViewControllerProtocol {
  
  func showError(_ message: String) {
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] (alert) in
        self.refreshControl.endRefreshing()
    }
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
  
  func reloadData() {
    refreshControl.endRefreshing()
    tableView.reloadData()
  }
  
  func showTopPlayers(statistics: Statistics) {
    let storyboard = UIStoryboard(name: "TopPlayers", bundle: nil)
    let identifier = String(describing: TopPlayersViewController.self)
    
    if let topPlayersViewController =
      storyboard.instantiateViewController(withIdentifier: identifier) as? TopPlayersViewController {
      let topPlayersViewModel = TopPlayersViewModel(viewController: topPlayersViewController,
                                                    statistics: statistics)
      
      topPlayersViewController.viewModel = topPlayersViewModel
      navigationController?.pushViewController(topPlayersViewController, animated: true)
    }
  }
}
