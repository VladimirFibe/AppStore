//
//  GamesViewController.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

class GamesViewController: UIViewController {
  var messages = Message.all
  var collectionView: UICollectionView!
  var dataSourse: UICollectionViewDiffableDataSource<Message, Reaction>?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.register(MessageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MessageHeaderView.reuseIdentifier)
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseIdentifier)
    createDataSource()
    reloadData()
  }
  
  func configure<T: SelfConfiguringMessage>(_ cellType: T.Type, with reaction: Reaction, for indexPath: IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)")}
    cell.configure(with: reaction)
    return cell
  }
  
  func createDataSource() {
    dataSourse = UICollectionViewDiffableDataSource<Message, Reaction>(collectionView: collectionView) { collectionView, indexPath, reaction in
      self.configure(MessageCell.self, with: reaction, for: indexPath)
    }
    dataSourse?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
      guard let messageHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MessageHeaderView.reuseIdentifier, for: indexPath) as? MessageHeaderView else { return nil }
      guard let first = self?.dataSourse?.itemIdentifier(for: indexPath) else { return nil }
      guard let message = self?.dataSourse?.snapshot().sectionIdentifier(containingItem: first) else { return nil }
      messageHeader.content.text = message.text
      return messageHeader
    }
  }
  
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Message, Reaction>()
    snapshot.appendSections(messages)
    for message in messages {
      snapshot.appendItems(message.reactions, toSection: message)
    }
    dataSourse?.apply(snapshot)
  }
  
  func createMessage(using message: Message) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(30))
    let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
    let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    let layoutSectionHeader = createMessageHeader()
    layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
    return layoutSection
  }
  func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { messageIndex, layoutEnvironment in
      let message = self.messages[messageIndex]
      return self.createMessage(using: message)
    }
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 20
    layout.configuration = config
    return layout
  }
  func createMessageHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let layoutMessageHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .fractionalHeight(1))
    let layoutMessageHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutMessageHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    return layoutMessageHeader
  }
}
