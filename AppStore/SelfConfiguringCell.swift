//
//  SelfConfiguringCell.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import Foundation

protocol SelfConfiguringCell {
  static var reuseIdentifier: String { get }
  func configure(with app: App)
}

protocol SelfConfiguringMessage {
  static var reuseIdentifier: String { get }
  func configure(with reaction: Reaction)
}
