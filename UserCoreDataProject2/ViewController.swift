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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
       // tableView.dataSource = self
    }


    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                
                self.navigationController?.pushViewController(registerViewController, animated: true)
    }

}

//extension ViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}

extension ViewController: UITableViewDelegate{
    
}


extension ViewController: UISearchBarDelegate {
    //MARK:- SEARCH BAR DELEGATE METHOD FUNCTION
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        //users = databaseManager.fetchUser()
        
        searchBar.endEditing(true)
        tableView.reloadData()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            //users = databaseManager.fetchUser()
        }else{
            //users = databaseManager.fetchUser(keyword: searchText)
        }
        
        tableView.reloadData()
    }
    
}
