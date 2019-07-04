//
//  ContactsTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    var contactViewModels = Array<ContactViewModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchAllContacts()
    }

    // MARK: - Private methods
    private func fetchAllContacts() {
        DataFetcher.shared.fetchAllContacts { (result, error) in
            if let result = result {
                for item in result {
                    guard let nItem = item as? Dictionary<String, Any> else { return }
                    let contact = Contact(id: nItem["id"] as? Int, firstName: nItem["first_name"] as? String, lastName: nItem["last_name"] as? String, profilePic: nItem["profile_pic"] as? String, favorite: nItem["favorite"] as? Bool, url: nItem["url"] as? String)
                    
                    let cViewModel = ContactViewModel(contact: contact)
                    self.contactViewModels.append(cViewModel)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            else {
                guard let error = error else { return }
                
            }
        }
    }
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
        
        let contactDetailViewController = segue.destination as? ContactDetailTableViewController
        contactDetailViewController?.contactViewModel = contactViewModels[selectedIndexPath.row]
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactViewModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        cell.contactViewModel = contactViewModels[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
