//
//  AccountListView.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 29.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import UIKit

class AccountListView: UIView {

    @IBOutlet weak var accountListTableView: UITableView! {
        didSet {
            accountListTableView.delegate = tableViewProvider
            accountListTableView.dataSource = tableViewProvider
        }
    }
    
    
    private let tableViewProvider = AccountListTableViewProvider()

}
