//
//  AppDelegate.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-04.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow()
        window?.rootViewController = MainTabBarController() // SignUpController()
        window?.makeKeyAndVisible()
        
       
        
        if let font = UIFont(name: "Pineapple Bold Inline", size: 30) {
            
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
, NSAttributedStringKey.font: font]
            
        }
        
        if let font = UIFont(name: "Pineapple Bold Inline", size: 45) {
            
            
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
            ]
            
        }
        
        if let font = UIFont(name: "Quicksand-Bold", size: 18) {
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.classForCoder() as! UIAppearanceContainer.Type]).setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        }
        
        let cancelButtonAttributes: NSDictionary = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [NSAttributedStringKey : AnyObject], for: UIControlState.normal)
        
        // Selected text
        let titleTextAttributesSelected = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        
        // Normal text
        let titleTextAttributesNormal = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        UISegmentedControl.appearance().tintColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        
        
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Strains", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)])
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)]
        
        
        
        return true
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

