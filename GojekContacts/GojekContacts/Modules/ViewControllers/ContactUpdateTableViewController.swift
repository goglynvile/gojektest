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
    weak var contactViewModel: ContactViewModel? {
        didSet {
            if let oldValue = oldValue {
                self.txtFirstName.text = oldValue.contact.firstName
                self.txtLastName.text = oldValue.contact.lastName
                // self.txtMobile.text = oldValue.contact
                // self.txtEmail.text = oldValue.contact
            }
        }
    }
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
    }
    
    
    // MARK: IBAction methods
    @IBAction func clickedCancel(_ sender: UIBarButtonItem) {
        self.delegate?.didCancelUpdate()
    }
    @IBAction func clickedDone(_ sender: UIBarButtonItem) {
        self.addContact()
    }
    func addContact() {
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
