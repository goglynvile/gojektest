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
        DataManager.shared.fetchAllContacts { (result, error) in
            if let result = result {
                
                print("contacts result: \(result)")
                for item in result {
                    guard let nItem = item as? Dictionary<String, Any> else { return }
                    let contact = Contact(item: nItem)
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
        if segue.identifier == "showDetail" {
            guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
            let contactDetailViewController = segue.destination as? ContactDetailTableViewController
            contactDetailViewController?.contactViewModel = contactViewModels[selectedIndexPath.row]
        }
        else if segue.identifier == "showAdd" {
            let addContactViewController = segue.destination as? ContactUpdateTableViewController
            addContactViewController?.delegate = self
            addContactViewController?.isNew = true
        }
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

extension ContactsTableViewController: ContactUpdateViewControllerDelegate {
    func didCancelUpdate() {
        self.dismiss(animated: true, completion: nil)
    }
    func didEditContact(contactViewModel: ContactViewModel) {
        
    }
    func didAddContact(contactViewModel: ContactViewModel) {
        self.dismiss(animated: true) {
            self.contactViewModels.insert(contactViewModel, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
}
