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
    private var hasLoaded = false
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAllContacts()
        
        self.tableView.sectionIndexColor = UIColor.darkGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedRow = self.selectedIndexPath {
            self.tableView.reloadRows(at: [selectedRow], with: .automatic)
        }
    }

    // MARK: - Private methods
    private func fetchAllContacts() {
        
        //self.showLoading()
        DataManager.shared.fetchAllContacts { (result, error) in
            if let result = result as? Array<Dictionary<String, Any>> {
                
                // sort result
                let sortedResult = result.sorted(by: {(($0["first_name"] as? String) ?? "") < (($1["first_name"] as? String) ?? "")})

                for item in sortedResult {
                    let contact = Contact(item: item)
                    let cViewModel = ContactViewModel(contact: contact)
                    
                    if let prefix = contact.firstName?.prefix(1) {
                        let key = String(prefix).uppercased()
                        var group = self.groups[key]
                        if group == nil {
                            group = Array<ContactViewModel>()
                            self.groups[String(prefix).uppercased()] = group
                        }
                        group?.append(cViewModel)
                        self.groups[key] = group
                    }
                }
                
                self.keys = Array(self.groups.keys)
                self.sortAtoZ()
                
                DispatchQueue.main.async {
                    self.hasLoaded = true
                    //self.hideLoading()
                    self.tableView.reloadData()
                }
            }
            else {
                guard let error = error else { return }
                    //self.hideLoading()
                    self.showAlert(title: Constant.App.name, message: error)
            }
        }
    }
    private func sortAtoZ() {
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
        return hasLoaded ? keys.count: 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return hasLoaded ? keys[section] : ""
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return hasLoaded ? keys : nil
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasLoaded {
            return 10
        }
        let key = keys[section]
        guard let contactViewModels = groups[key] else { fatalError()}
        return contactViewModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !hasLoaded {
            let nCell = tableView.dequeueReusableCell(withIdentifier: "skeleton", for: indexPath) as! PreloadingTableViewCell
            
            return nCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        
        let key = keys[indexPath.section]
        guard let contactViewModels = groups[key] else { fatalError() }
        let contactViewModel = contactViewModels[indexPath.row]
        cell.contactViewModel = contactViewModel
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !hasLoaded {
            return
        }
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !hasLoaded {
            return
        }
        if editingStyle == .delete {
            
            self.showAlert(title: Constant.App.name, action: UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                let key = self.keys[indexPath.section]
                guard var contactViewModels = self.groups[key] else { fatalError() }
                let contactViewModel = contactViewModels[indexPath.row]
                
                guard let id = contactViewModel.contact.id else { return }
                DataManager.shared.deleteContact(id: id) { (result, error) in
                    DispatchQueue.main.async {
                        self.showAlert(title: Constant.App.name, message: Constant.Text.successDeleted(name: contactViewModel.fullName))
                        
                        contactViewModels.remove(at: indexPath.row)
                        self.groups[key] = contactViewModels

                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }), message: Constant.Text.deleteContact)
        }
    }
}

extension ContactsTableViewController: ContactUpdateViewControllerDelegate {
    func didCancelUpdate() {
        self.dismiss(animated: true, completion: nil)
    }
    func didAddContact(contactViewModel: ContactViewModel) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                
                let contact = contactViewModel.contact

                guard let prefix = contact.firstName?.prefix(1) else { return }
                
                let key = String(prefix).uppercased()
                var group = self.groups[key]
                if group == nil {
                    group = Array<ContactViewModel>()
                }
                group?.append(contactViewModel)
                
                self.groups[key] = group?.sorted(by: { ($0.contact.firstName ?? "") < ($1.contact.firstName ?? "")})
                let row = self.groups[key]?.firstIndex(where: {$0.contact.id == contactViewModel.contact.id
                })
                
                self.keys = Array(self.groups.keys)
                self.sortAtoZ()
                
                self.showAlert(title: Constant.App.name, message: Constant.Text.successAdded(name: contactViewModel.fullName))
                
                if let section = self.keys.firstIndex(of: key) {
                    self.tableView.reloadSections(IndexSet(integer: section), with: .automatic)
                    self.tableView.scrollToRow(at: IndexPath(row: row ?? 0, section: section), at: .top, animated: true)
                }
            }
        }
        
    }
}
