//
//  HomeController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-05.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import Firebase
import GlidingCollection

class HomeController: UICollectionViewController {
    
    // Going to try to implement https://github.com/Ramotion/gliding-collection
    let items = ["Favorites", "New Arrivals", "Sales", "Suggestions"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9450980392, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        
        
        //fetchUser()
        setupViews()
        setupLogOutButton()
        
        
    }
    
    fileprivate func setupLogOutButton() {
        let logoutButton = UIBarButtonItem(image: #imageLiteral(resourceName: "logOut").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem = logoutButton
        
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
                
            } catch let signOutError {
                print("Failed to sign out: ", signOutError)
            }
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
//    fileprivate func fetchUser() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
//            print(snapshot.value ?? "")
//            guard let dictionary = snapshot.value as? [String: Any] else { return }
//            let username = dictionary["username"] as? String
//            self.titleLabel.text = "Welcome \(username ?? "")"
//        }
//    }
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        //label.text = "Welcome"
//        label.font = UIFont(name: "Quicksand-Bold", size: 30)
//        label.textAlignment = .center
//        return label
//    }()
    
    fileprivate func setupViews() {
        
    }
}





