//
//  SearchViewController.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

class ListCell: UICollectionViewCell {
  static var reuseIdentifier: String = "ListCell"
  let label = UILabel()
  let accessoryImageView = UIImageView()
  let separatorView = UIView()
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ListCell {
  func setupViews() {
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .body)
    contentView.addSubview(label)

    separatorView.translatesAutoresizingMaskIntoConstraints = false
    separatorView.backgroundColor = .lightGray
    contentView.addSubview(separatorView)

    selectedBackgroundView = UIView()
    selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

    accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(accessoryImageView)

    let rtl = effectiveUserInterfaceLayoutDirection == .rightToLeft
    let chevronImageName = rtl ? "chevron.left" : "chevron.right"
    let chevronImage = UIImage(systemName: chevronImageName)
    accessoryImageView.image = chevronImage
    accessoryImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
  }

  func configure(with name: String) {
    label.text = name
  }

  func setupConstraints() {
    let inset = 10.0
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
      label.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -inset),

      accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
      accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
      accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),

      separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
      separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      separatorView.heightAnchor.constraint(equalToConstant: 0.5)

    ])
  }
}

class TextCell: UICollectionViewCell {
  static let reuseIdentifier = "TextCell"
  let label = UILabel()
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemBlue
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    contentView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textAlignment = .center
  }
  
  func setupConstraints() {
    let inset = 10.0
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
      label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
    ])
  }
  
  func configure(with name: String) {
    label.text = name
    contentView.layer.borderColor = UIColor.black.cgColor
    contentView.layer.borderWidth = 1
    contentView.layer.cornerRadius = 8
  }
}

class BadgeSupplementaryView: UICollectionViewCell {
  static let reuseIdentifier = "BadgeSupplementaryView"
  let label = UILabel()
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var frame: CGRect {
    didSet { configureBorder()}
  }
  
  override var bounds: CGRect {
    didSet { configureBorder()}
  }
  
  func configureBorder() {
    let radius = bounds.width / 2
    layer.cornerRadius = radius
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 1.0
    clipsToBounds = true
  }
  
  func setupViews() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textAlignment = .center
    backgroundColor = .green
    label.textColor = .black
    configureBorder()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
  
  func configure(with name: String) {
    label.text = name
  }
}
class SearchViewController: UIViewController {
  enum Section {
    case main
  }
  struct Model: Hashable {
    let title: String
    let badgeCount: Int
    let identifier = UUID()
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }
  }
  static let badgeElementKind = "badgeElementKind"
  var dataSource: UICollectionViewDiffableDataSource<Section, Model>! = nil
  var collectionView: UICollectionView! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureHierarchy()
    configureDataSource()
  }
  
  private func configureHierarchy() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createGridLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
    collectionView.register(BadgeSupplementaryView.self,
                            forSupplementaryViewOfKind: SearchViewController.badgeElementKind,
                            withReuseIdentifier: BadgeSupplementaryView.reuseIdentifier)
    view.addSubview(collectionView)
  }
  
  func createListLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  
  func createGridLayout() -> UICollectionViewLayout {
    let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
    let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
    let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: Self.badgeElementKind, containerAnchor: badgeAnchor)
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing:   5)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.2))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Model>(collectionView: collectionView) { collectionView, indexPath, model in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCell.reuseIdentifier, for: indexPath) as? TextCell else { fatalError("Cannot create new cell")}
      cell.configure(with: model.title)
      return cell
    }
    
    dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView,
                                                          kind: String,
                                                          indexPath: IndexPath) -> UICollectionReusableView? in
      guard let self = self, let model = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
      let hasBadgeCount = model.badgeCount > 0
      if let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeSupplementaryView.reuseIdentifier, for: indexPath) as? BadgeSupplementaryView {
        badgeView.configure(with: "\(model.badgeCount)")
        badgeView.isHidden = !hasBadgeCount
        return badgeView
      } else {
        fatalError("Cannot create new supplementary")
      }
    }
    var snapshot = NSDiffableDataSourceSnapshot<Section, Model>()
    snapshot.appendSections([.main])
    let models = (0..<100).map { Model(title: "\($0)", badgeCount: Int.random(in: 0..<3))}
    snapshot.appendItems(models)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}
