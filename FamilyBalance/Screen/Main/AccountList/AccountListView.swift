
import UIKit


protocol AccountListViewImplementation {
    func setActionsDelegate(delegate: AccountListViewActions)
    func showAccounts(_ accounts: [Account])
    func setSelectedAccount(_ account: Account)
}

protocol AccountListViewActions {
    func viewDidLoad()
    func wasSelectedAccount(account: Account)
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
    
    func showAccounts(_ accounts: [Account]) {
        tableViewProvider.accounts = accounts
        accountListTableView.reloadData()
    }
    
    func setSelectedAccount(_ account: Account) {
        tableViewProvider.selectedAccount = account
        accountListTableView.reloadData()
    }
    
    
}
