//
//  MediumTableCell.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
  static var reuseIdentifier: String = "MediumTableCell"
  
  let name = UILabel()
  let subtitle = UILabel()
  let imageView = UIImageView()
  let buyButton = UIButton(type: .custom)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    name.font = UIFont.preferredFont(forTextStyle: .headline)
    name.textColor = .label
    
    subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
    subtitle.textColor = .secondaryLabel
    
    imageView.layer.cornerRadius = 15
    imageView.clipsToBounds = true
    
    buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
    
    imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    
    let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
    innerStackView.axis = .vertical
    
    let stackView = UIStackView(arrangedSubviews: [imageView, innerStackView, buyButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.spacing = 10
    contentView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with app: App) {
    name.text = app.name
    subtitle.text = app.subheading
    imageView.image = UIImage(named: app.image)
  }
}
