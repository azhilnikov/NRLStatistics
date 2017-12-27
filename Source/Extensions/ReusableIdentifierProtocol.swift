//
//  ReusableIdentifierProtocol.swift
//  NRLStatistics
//
//  Created by Alexey on 26/12/17.
//  Copyright © 2017 Alexey Zhilnikov. All rights reserved.
//

import UIKit

protocol HasReusableIdentifier: class {
  static var reusableIdentifier: String { get }
}

extension HasReusableIdentifier where Self: UIView {
  static var reusableIdentifier: String {
    return String(describing: self).components(separatedBy: ".").last!
  }
}

extension UITableViewCell: HasReusableIdentifier {}
extension UITableViewHeaderFooterView: HasReusableIdentifier {}

extension UITableView {
  
  func registerNib<T: UITableViewCell>(_: T.Type) {
    let nib = UINib(nibName: T.reusableIdentifier, bundle: nil)
    self.register(nib, forCellReuseIdentifier: T.reusableIdentifier)
  }
  
  func registerNibForHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) {
    let nib = UINib(nibName: T.reusableIdentifier, bundle: nil)
    self.register(nib, forHeaderFooterViewReuseIdentifier: T.reusableIdentifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
      fatalError("Dequeue failed for reusable identifier: \(T.reusableIdentifier)")
    }
    return cell
  }
  
  func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
    guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: T.reusableIdentifier) as? T else {
      fatalError("Dequeue failed for header footer view with reusable identifier: \(T.reusableIdentifier)")
    }
    return headerFooterView
  }
}
