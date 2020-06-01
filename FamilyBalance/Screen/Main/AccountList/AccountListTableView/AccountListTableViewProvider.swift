
import UIKit


class AccountListTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Open metods
    var accounts = [Account]()
    var selectedAccount: Account?
    
    var actionsDelegate: AccountListViewActions?
    
    
    //MARK: - TableViewProvider metods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let account = accounts[indexPath.row]
        cell.textLabel?.text = account.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if accounts[indexPath.row] == selectedAccount {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if accounts[indexPath.row] != selectedAccount {
            selectedAccount = accounts[indexPath.row]
            actionsDelegate?.wasSelectedAccount(account: selectedAccount!)
        }
    }
    
}
