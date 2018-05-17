//
//  MainTabBarController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-04.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if logged in
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                return
            }
            
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        // Home
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"), rootViewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Products
        let productsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "strains"), selectedImage: #imageLiteral(resourceName: "strains"), rootViewController: ProductsController())
        
        // Info
        let infoNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "about"), selectedImage: #imageLiteral(resourceName: "about"))
        
        // Specials
        let specialsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "money"), selectedImage: #imageLiteral(resourceName: "money"))
        
        // Cart
        let cartNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "shopping_cart"), selectedImage: #imageLiteral(resourceName: "shopping_cart"))
        
        tabBar.tintColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        
        viewControllers = [homeNavController, productsNavController, infoNavController, specialsNavController, cartNavController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }   
}
