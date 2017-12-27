//
//  PlayerViewController.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

  @IBOutlet private weak var playerImageView: UIImageView!
  @IBOutlet private weak var dateOfBirthLabel: UILabel!
  @IBOutlet private weak var heightLabel: UILabel!
  @IBOutlet private weak var weightLabel: UILabel!
  @IBOutlet private weak var positionLabel: UILabel!
  @IBOutlet private weak var lastMatchErrorsLabel: UILabel!
  @IBOutlet private weak var lastMatchGoalsLabel: UILabel!
  @IBOutlet private weak var lastMatchPointsLabel: UILabel!
  @IBOutlet private weak var lastMatchRunsLabel: UILabel!
  @IBOutlet private weak var lastMatchTacklesLabel: UILabel!
  @IBOutlet private weak var lastMatchTriesLabel: UILabel!
  @IBOutlet private weak var lastMatchMinutesPlayedLabel: UILabel!
  @IBOutlet private weak var lastMatchRunMetresLabel: UILabel!
  
  var viewModel: PlayerViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareUI()
    viewModel.fetchPlayer()
  }
  
  @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }
  
  private func prepareUI() {
    viewModel.playerImage() { [weak self] image in
      self?.playerImageView.image = image
    }
  }
}

extension PlayerViewController: PlayerViewControllerProtocol {
  
  func showError(_ message: String) {
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
  
  func reloadData() {
    navigationItem.title = viewModel.title
    dateOfBirthLabel.text = viewModel.dateOfBirth
    heightLabel.text = viewModel.height
    weightLabel.text = viewModel.weight
    positionLabel.text = viewModel.position
    lastMatchErrorsLabel.text = viewModel.lastMatchErrors
    lastMatchGoalsLabel.text = viewModel.lastMatchGoals
    lastMatchPointsLabel.text = viewModel.lastMatchPoints
    lastMatchRunsLabel.text = viewModel.lastMatchRuns
    lastMatchTacklesLabel.text = viewModel.lastMatchTackles
    lastMatchTriesLabel.text = viewModel.lastMatchTries
    lastMatchMinutesPlayedLabel.text = viewModel.lastMatchMinsPlayed
    lastMatchRunMetresLabel.text = viewModel.lastMatchRunMetres
  }
}
