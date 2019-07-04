//
//  ContactDetailTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {

    // MARK: Public variables
    weak var contactViewModel: ContactViewModel? {
        didSet {
            if let oldValue = oldValue {
//                self.txtFirstName.text = oldValue.contact.firstName
//                self.txtLastName.text = oldValue.contact.lastName
               // self.txtMobile.text = oldValue.contact
               // self.txtEmail.text = oldValue.contact
            }
        }
    }
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ContactDetailHeaderView.nib, forHeaderFooterViewReuseIdentifier: ContactDetailHeaderView.reuseIdentifier)
        self.addEditButton()
    }
    // MARK: Private methods
    private func addEditButton() {
        let btnEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clickedEdit(sender:)))
        self.navigationItem.rightBarButtonItem = btnEdit
    }
    @objc func clickedEdit(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showEdit", sender: sender)
    }
    
    // MARK: Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactEditViewController = segue.destination as? ContactEditTableViewController
        contactEditViewController?.contactViewModel = contactViewModel
    }
    
    // MARK: TableView delegate/datasource
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ContactDetailHeaderView.reuseIdentifier) as? ContactDetailHeaderView
        headerView?.contactViewModel = contactViewModel
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 340
    }
}
