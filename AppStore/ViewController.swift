import UIKit

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let app = UINavigationController(rootViewController: AppsViewController())
        let games = UINavigationController(rootViewController: GamesViewController())
        let arcade = UINavigationController(rootViewController: FoodController())
        let search = SearchViewController()
        app.tabBarItem = UITabBarItem(title: "App", image: UIImage(systemName: "square.stack.3d.up.fill"), tag: 0)
        games.tabBarItem = UITabBarItem(title: "Games", image: UIImage(systemName: "gamecontroller"), tag: 1)
        arcade.tabBarItem = UITabBarItem(title: "Arcade", image: UIImage(systemName: "dollarsign.circle"), tag: 2)
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        setViewControllers([app, games, arcade, search], animated: false)
    }
}

