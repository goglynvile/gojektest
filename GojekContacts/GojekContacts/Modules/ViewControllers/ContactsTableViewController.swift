//
//  ContactsTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    // MARK: Private properties
    private var groups = Dictionary<String, Array<ContactViewModel>>()
    private var keys = Array<String>()
    private var selectedIndexPath: IndexPath?
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAllContacts()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedRow = self.selectedIndexPath {
            self.tableView.reloadRows(at: [selectedRow], with: .automatic)
        }
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
                    
                    if let prefix = contact.firstName?.prefix(1) {
                        var group = self.groups[String(prefix).uppercased()]
                        if group == nil {
                            group = Array<ContactViewModel>()
                        }
                        group?.append(cViewModel)
                        self.groups[String(prefix).uppercased()] = group
                    }
                }
                
                self.keys = Array(self.groups.keys)
                self.sortAtoZ()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else {
                guard let error = error else { return }
                
            }
        }
    }
    private func sortAtoZ() {
       // self.contactViewModels.sort(by: { $0.fullName < $1.fullName })
       // self.groups = self.groups.sorted(by: { $0.key < $1.key})
        self.keys.sort(by: { $0 < $1})
    }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else { return }
            self.selectedIndexPath = selectedIndexPath
            let contactDetailViewController = segue.destination as? ContactDetailTableViewController
            
            let key = keys[selectedIndexPath.section]
            guard let contactViewModels = groups[key] else { fatalError() }
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
        return keys.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        guard let contactViewModels = groups[key] else { fatalError()}
        return contactViewModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        
        let key = keys[indexPath.section]
        guard let contactViewModels = groups[key] else { fatalError() }
        let contactViewModel = contactViewModels[indexPath.row]
        cell.contactViewModel = contactViewModel
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
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                
//                self.contactViewModels.insert(contactViewModel, at: 0)
//                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }
        
    }
}
