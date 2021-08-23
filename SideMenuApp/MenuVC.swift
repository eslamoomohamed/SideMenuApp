//
//  MenuVC.swift
//  SideMenuApp
//
//  Created by eslam on 6/19/21.
//

import UIKit

class MenuVC: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .green
        navigationItem.title = "Home"
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Menu Row is: \(indexPath.row)"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
