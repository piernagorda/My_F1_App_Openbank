//
//  TabBarController.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 7/8/23.
//

import UIKit

final class TabBarController: UITabBarController{
    
    private var homeCollectionViewController: HomeViewCollectionController?
    private var mapViewController: MapViewController?
    private var settingsViewController: SettingsViewController?
    private var timeViewController: TimeViewController?
    
    override func viewDidLoad() {
        
        
        
        //homeTableViewController = HomeTableViewController(nibName: "HomeTableView", bundle: nil)
        //homeTableViewController?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "car.fill"), tag: 0)
        homeCollectionViewController = HomeViewCollectionController(nibName: "HomeViewCollection", bundle: nil)
        homeCollectionViewController?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        timeViewController = TimeViewController(homeViewController: homeCollectionViewController)
        timeViewController?.tabBarItem = UITabBarItem(title: "Year Change", image: UIImage(named: "time"), tag: 1)
        
        self.settingsViewController = SettingsViewController()
        settingsViewController?.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 2)
        
        //Asignacion de los controladores a la Tab Bar
        self.viewControllers = [homeCollectionViewController!, timeViewController!, settingsViewController!]
        navigationItem.title = "F1 Circuits of \(homeCollectionViewController!.homeViewModel!.getYear())"
        //tabBar.imageIn= UIEdgeInsets(top: -4, left: -4, bottom: -4, right: -4)
        navigationItem.setHidesBackButton(true, animated: true)
        super.viewDidLoad()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.title != "Settings"){
            navigationItem.title = "F1 Circuits of \(self.homeCollectionViewController!.homeViewModel!.getYear())"
        }
        else{
            navigationItem.title = item.title
        }
    }
}
