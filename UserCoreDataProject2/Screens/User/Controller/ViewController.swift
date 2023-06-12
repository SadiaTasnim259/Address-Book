//
//  ViewController.swift
//  UserCoreDataProject2
//
//  Created by Sadia on 8/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var databaseManager = DatabaseManager()
    private var users: [UserEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = databaseManager.fetchUserAllUser()
        tableView.reloadData()
    }


    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        addUpdateUserNavigation()
    }
    
    func addUpdateUserNavigation (user: UserEntity? = nil){
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        registerViewController.existingUser = user
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else{
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.user = user
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { _, _, _ in
            self.addUpdateUserNavigation(user: self.users[indexPath.row] )// je user select hobe tar indexpath.row te je data asbe ta pass korbo ta registervc pabe
        }
        update.backgroundColor = .systemIndigo
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.databaseManager.deleteUser(userEntity: self.users[indexPath.row]) // coredata theke delete // age core data theke delete na korle problem ache
            self.users.remove(at: indexPath.row) // Array // table view theke dlt
            self.tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete,update ])
    }
}


extension ViewController: UISearchBarDelegate {
    //MARK:- SEARCH BAR DELEGATE METHOD FUNCTION
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        users = databaseManager.fetchUserAllUser()
        
        searchBar.endEditing(true)
        tableView.reloadData() ///sob data dekhabe
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            users = databaseManager.fetchUserAllUser()
        }else{
            users = databaseManager.fetchSearchedUser(keyword: searchText)
        }
        
        tableView.reloadData()
    }
    
}
