//
//  AppsViewController.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

class AppsViewController: UIViewController {
  let sections = Bundle.main.decode([Section].self, frome: "appstore.json")
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, App>?
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "AppStore"
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .red //.systemBackground
    view.addSubview(collectionView)
    collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
    createDataSource()
    reloadData()
  }
  
  func configure<T: SelfConfiguringCell>(_ cellType: T.Type, wiht app: App, for indexPath: IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)")}
    cell.configure(with: app)
    return cell
  }
  
  func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, App>(collectionView: collectionView) { collectionView, indexPath, app in
      switch self.sections[indexPath.section].type {
      default: return self.configure(FeaturedCell.self, wiht: app, for: indexPath)
      }
    }
  }
  
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
    snapshot.appendSections(sections)
    for section in sections {
      snapshot.appendItems(section.items, toSection: section)
    }
    dataSource?.apply(snapshot)
  }
}
