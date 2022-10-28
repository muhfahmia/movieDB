//
//  TabBarViewController.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 25/10/22.
//

import UIKit

class TabBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBarController()
        let moviesVC = UINavigationController(rootViewController: MoviesViewController())
        let loginVC = UINavigationController(rootViewController: LoginViewController())

        tabBar.setViewControllers([moviesVC,loginVC], animated: false)
        guard let items = tabBar.tabBar.items else { return }

        let itemsIcon = ["person.fill.questionmark","person.fill.questionmark"]

        for x in 0..<items.count {
            items[x].image = UIImage(systemName: itemsIcon[x])
        }
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
