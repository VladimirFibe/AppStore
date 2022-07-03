//
//  MessageCell.swift
//  AppStore
//
//  Created by Vladimir Fibe on 02.07.2022.
//

import UIKit

class MessageCell: UICollectionViewCell, SelfConfiguringMessage {
  static var reuseIdentifier: String = "MessageCell"
  let title = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.layer.cornerRadius = 8
    contentView.clipsToBounds = true
    contentView.backgroundColor = .lightGray
    title.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(title)
    NSLayoutConstraint.activate([
      title.topAnchor.constraint(equalTo: contentView.topAnchor),
      title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with reaction: Reaction) {
    title.text = reaction.title
  }
}
