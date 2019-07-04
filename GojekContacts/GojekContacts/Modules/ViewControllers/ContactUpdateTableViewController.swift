//
//  ContactEditTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

protocol ContactUpdateViewControllerDelegate {
    func didAddContact(contactViewModel: ContactViewModel)
    func didEditContact(contactViewModel: ContactViewModel)
    func didCancelUpdate()
}

class ContactUpdateTableViewController: UITableViewController {
 
    // MARK: Public variables
    weak var contactViewModel: ContactViewModel?
    var isNew: Bool = false
    var delegate: ContactUpdateViewControllerDelegate?
    
    // MARK: Public IBOutlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.tableView.register(ContactEditHeaderView.nib, forHeaderFooterViewReuseIdentifier: ContactEditHeaderView.reuseIdentifier)
        
        if !isNew {
            self.updateUI()
        }
    }
    
    
    // MARK: IBAction methods
    @IBAction func clickedCancel(_ sender: UIBarButtonItem) {
        self.delegate?.didCancelUpdate()
    }
    @IBAction func clickedDone(_ sender: UIBarButtonItem) {
        if isNew {
            self.addContact()
        }
        else {
            self.editContact()
        }
    }
    
    // MARK: Private methods
    private func addContact() {
        var item = Parameters()
        
        item["first_name"] = txtFirstName.text
        item["last_name"] = txtLastName.text
        item["email"] = txtEmail.text
        item["phone_number"] = txtMobile.text
        print("adding...")
        
        DataManager.shared.addContact(item: item) { (result, error) in
            if let result = result {
                print("add result: \(result)")
                let contact = Contact(item: result)
                let cViewModel = ContactViewModel(contact: contact)
                self.delegate?.didAddContact(contactViewModel: cViewModel)
            }
            else {
                guard let error = error else { return }
            }
        }
    }
    private func editContact() {
        var item = Parameters()
        
        item["first_name"] = txtFirstName.text
        item["last_name"] = txtLastName.text
        item["email"] = txtEmail.text
        item["phone_number"] = txtMobile.text
        
        guard let id = contactViewModel?.contact.id else { return }
        
        DataManager.shared.editContact(id: id, item: item) { (result, error) in
            if let result = result {
                print("edit result: \(result)")
                self.contactViewModel?.contact.update(item: result)
                self.delegate?.didEditContact(contactViewModel: self.contactViewModel!)
            }
            else {
                guard let error = error else { return }
            }
        }
    }
    private func updateUI() {
        if let cViewModel = contactViewModel {
            self.txtFirstName.text = cViewModel.contact.firstName
            self.txtLastName.text = cViewModel.contact.lastName
            self.txtMobile.text = cViewModel.contact.phoneNumber
            self.txtEmail.text = cViewModel.contact.email
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 260
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ContactEditHeaderView.reuseIdentifier) as? ContactEditHeaderView
        headerView?.contactViewModel = contactViewModel
        return headerView
    }

}
