//
//  CategoryListTableViewProviderNew.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 01.06.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class CategoryListTableViewProvider: NSObject, TableViewProvider {
    
    var categories = [Category]()
    private var selectedCategory: Category?
    
    
    //MARK: - Open metods
    func setSelectedCategory(_ category: Category) {
        selectedCategory = category
    }
    
    
    //MARK: - TableViewProvider
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if categories[indexPath.row] == selectedCategory {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if categories[indexPath.row] != selectedCategory {
            selectedCategory = categories[indexPath.row]
            tableView.reloadData()
        }
    }
    
}
