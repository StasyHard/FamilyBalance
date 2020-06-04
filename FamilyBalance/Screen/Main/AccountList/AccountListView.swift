
import UIKit


protocol AccountListViewImplementation {
    func setActionsDelegate(delegate: AccountListViewActions)
    func showAccounts(_ accounts: [AccountModel])
    func setSelectedAccount(_ account: AccountModel)
}

protocol AccountListViewActions {
    func viewDidLoad()
    func wasSelectedAccount(account: AccountModel)
}


final class AccountListView: UIView {

    @IBOutlet weak var accountListTableView: UITableView! {
        didSet {            
            accountListTableView.delegate = tableViewProvider
            accountListTableView.dataSource = tableViewProvider
        }
    }
    
    
    private let tableViewProvider = AccountListTableViewProvider()

}



extension AccountListView: AccountListViewImplementation {
    
    func setActionsDelegate(delegate: AccountListViewActions) {
        tableViewProvider.actionsDelegate = delegate
    }
    
    func showAccounts(_ accounts: [AccountModel]) {
        tableViewProvider.accounts = accounts
        accountListTableView.reloadData()
    }
    
    func setSelectedAccount(_ account: AccountModel) {
        tableViewProvider.selectedAccount = account
        accountListTableView.reloadData()
    }
    
    
}
