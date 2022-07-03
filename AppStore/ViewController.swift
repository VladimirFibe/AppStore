//
//  ViewController.swift
//  AppStore
//
//  Created by Vladimir Fibe on 01.07.2022.
//

import UIKit

class ViewController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  func setupViews() {
    let games = UINavigationController(rootViewController: GamesViewController())
    let app = UINavigationController(rootViewController: AppsViewController())
    let arcade = ArcadeViewController()
    let search = SearchViewController()
    
    setViewControllers([games, app, arcade, search], animated: false)
    guard let items = tabBar.items else { return }
    items[0].image = UIImage(systemName: "gamecontroller")
    items[1].image = UIImage(systemName: "square.stack.3d.up.fill")
    items[2].image = UIImage(systemName: "dollarsign.circle")
    items[3].image = UIImage(systemName: "magnifyingglass")
    items[0].title = "Games"
    items[1].title = "App"
    items[2].title = "Arcade"
    items[3].title = "Search"
  }

}

