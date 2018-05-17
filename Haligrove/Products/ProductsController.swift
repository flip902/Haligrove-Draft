//
//  ProductsController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-05.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class ProductsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        setupTableView()
        
    }
    
    
    fileprivate func setupTableView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Products"
        tableView.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        
        tableView.register(ProductsCell.self, forCellReuseIdentifier: "reuseIdentifier")
       
        tableView.isScrollEnabled = false
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screen = view.frame.height
        let navBar = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height)!
        let tabBar = tabBarController?.tabBar.frame.size.height
        return (screen - navBar - tabBar!) / 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ProductsCell
        
        cell.productImageView.image = UIImage(named: products[indexPath.item].image!)?.withRenderingMode(.alwaysTemplate)
        cell.productImageView.tintColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        cell.productImageView.layer.shadowColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        cell.productImageView.layer.shadowRadius = 1.0
        cell.productImageView.layer.shadowOpacity = 0.7
        cell.productImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        cell.productLabel.text = products[indexPath.item].title
        
        cell.rightArrow.tintColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        cell.rightArrow.layer.shadowColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        cell.rightArrow.layer.shadowRadius = 1.0
        cell.rightArrow.layer.shadowOpacity = 0.8
        cell.rightArrow.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        return cell
    }
    
    struct ProductsInfo {
        var image: String?
        var title: String?
    }
    
    let products = [
        ProductsInfo(image: "strainsIcon", title: "Strains"),
        ProductsInfo(image: "hashIcon", title: "Hash"),
        ProductsInfo(image: "extractsIcon", title: "Extracts"),
        ProductsInfo(image: "ediblesIcon", title: "Edibles"),
        ProductsInfo(image: "paraphernaliaIcon", title: "Paraphernalia")
    ]
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = products[indexPath.row]
        print("indexPath: \(selectedCell)")
        
        if selectedCell.title == "Strains" {
            let strainsController = StrainsViewController()
            
                self.navigationController?.pushViewController(strainsController, animated: true)
        }
        
        if selectedCell.title == "Hash" {
            let hashController = HashViewController()
                self.navigationController?.pushViewController(hashController, animated: true)
         }
        
        if selectedCell.title == "Extracts" {
            let extractsController = ExtractsViewController()
               self.navigationController?.pushViewController(extractsController, animated: true)
        }
        
        if selectedCell.title == "Edibles" {
            let ediblesController = EdiblesViewController()
                self.navigationController?.pushViewController(ediblesController, animated: true)
        }
        
        if selectedCell.title == "Paraphernalia" {
            let paraphernaliaController = ParaphernaliaViewController()
                self.navigationController?.pushViewController(paraphernaliaController, animated: true)
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        tableView.reloadData()
        
    }
}














