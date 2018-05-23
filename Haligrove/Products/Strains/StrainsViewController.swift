//
//  StrainsViewController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-16.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

enum StrainType: String {
    case indica = "Indica"
    case sativa = "Sativa"
    case hybrid = "Hybrid"
}

struct Strain: Decodable {
    let id: UUID
    let name: String
    let src: String
    let type: String
    let isNew: String
    let pricePerGram: Float
    let priceForFive: Float
    let pricePerOunce: Float
    let sale: String
    let salePricePerGram: Float
    let salePriceForFive: Float
    let salePricePerOunce: Float
    let description: String
    let inventory: String
    let THC: Int
    let taste: Int
    let aroma: Int
    let pain: Int
    let insomnia: Int
    let appetite: Int
    let overall: Int
    let soldOut: String
}



extension StrainsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension StrainsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

class StrainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var strains = [Strain]()
    var filteredStrains = [Strain]()
    
    
    let closeHeight: CGFloat = 136
    let openHeight: CGFloat = 375
    var rowsCount: Int = 50
    var itemHeight: [CGFloat] = []
    
    let searchController = UISearchController(searchResultsController: nil)
   private var strainsTableView: UITableView!
    let reuseIdentifier = "strainCell"
    
    
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
        func filterContentForSearchText(_ searchText: String, scope: String = "All") {
            filteredStrains = strains.filter({(strain: Strain) -> Bool in
                let doesCategoryMatch = (scope == "All") || (strain.type == scope)
                if searchBarIsEmpty() {
                    return doesCategoryMatch
                } else {
                    return doesCategoryMatch && strain.name.lowercased().contains(searchText.lowercased())
                }
    
            })
    
            strainsTableView.reloadData()
        }
    
    
    
    fileprivate func fetchJSON() {
        let urlString = "http://app.haligrove.com/strainData.json"
        guard let url = URL(string: urlString) else { return }
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
       
        URLSession(configuration: config).dataTask(with: url) { (data, res, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed: ", err)
                    return
                }
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    self.strains = try decoder.decode([Strain].self, from: data)
                    
                    print(self.strains)
                    
                    self.strainsTableView.reloadData()
                } catch let jsonErr {
                    print("Failed: ", jsonErr)
                }
            }
            }.resume()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    private func setup() {
        itemHeight = Array(repeating: closeHeight, count: rowsCount)
        strainsTableView.estimatedRowHeight = closeHeight
        strainsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJSON()
        
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["All", "indica", "sativa", "hybrid"]
        searchController.searchBar.delegate = self
        
        
        
        
        //        let screenHeight: CGFloat = view.frame.height
        //        let screenWidth: CGFloat = view.frame.width
        //        let navBar: CGFloat = UIApplication.shared.statusBarFrame.size.height +
        //            (self.navigationController?.navigationBar.frame.height)!
        //        let tabBar: CGFloat = (tabBarController?.tabBar.frame.size.height)!
        
        strainsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)
        //UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        //        strainsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        strainsTableView.register(StrainsFoldingCell.self, forCellReuseIdentifier: reuseIdentifier)
        strainsTableView.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        strainsTableView.dataSource = self
        strainsTableView.delegate = self
        self.view.addSubview(strainsTableView)
        
        navigationItem.title = "Strains"
        
        
        strainsTableView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        setup()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if isFiltering() {
                     return filteredStrains.count
                }
        
       
        return strains.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as StrainsFoldingCell = cell else { return }
        if itemHeight[indexPath.row] == closeHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StrainsFoldingCell
        //        if (cell != nil) {
        //            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        //        }
        
        //        cell.textLabel?.text = strain.name
        //        cell.detailTextLabel?.text = strain.type.rawValue
        
        
        // How do I pass strain over to my StrainsFoldingCell so that i can input the data into the labels.
        // How to get reference to strain[indexPath.row] inside StrainsFoldingCell
        
//        if let imageURl = URL(string: strains[indexPath.row].src) {
//            do {
//                let data = try Data(contentsOf: imageURl)
//                let image = UIImage(contentsOfFile: data)
//            } catch {
//                print("couldn't load image")
//            }
//
//        }
        let strain: Strain
        
        if isFiltering() {
            strain = filteredStrains[indexPath.row]
        } else {
            strain = strains[indexPath.row]
        }
               // Start of Sean's Code
        cell.set(strain: strain) //Passing the variable you created on line 212 here
        // End of Sean's Code
        
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return closeHeight
                return itemHeight[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StrainsFoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight {
            itemHeight[indexPath.row] = openHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            itemHeight[indexPath.row] = closeHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        strainsTableView.reloadData()
        
    }
}
