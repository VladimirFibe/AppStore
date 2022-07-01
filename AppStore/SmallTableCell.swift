//
//  SmallTableCell.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

class SmallTableCell: UICollectionViewCell, SelfConfiguringCell {
  static var reuseIdentifier: String = "SmallTableCell"
  
  let name = UILabel()
  let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    name.font = UIFont.preferredFont(forTextStyle: .title2)
    name.textColor = .label
    
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    
    let stackView = UIStackView(arrangedSubviews: [imageView, name])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.spacing = 20
    contentView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func configure(with app: App) {
    name.text = app.name
    imageView.image = UIImage(named: app.image)
  }
  
    
}
