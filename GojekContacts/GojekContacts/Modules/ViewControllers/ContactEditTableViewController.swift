//
//  ContactEditTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactEditTableViewController: UITableViewController {
 
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
    
    // MARK: Public IBOutlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.tableView.register(ContactEditHeaderView.nib, forHeaderFooterViewReuseIdentifier: ContactEditHeaderView.reuseIdentifier)
        self.addButtons()
    }
    
    
    
    // MARK: Private methods
    private func addButtons() {
        let btnCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(clickedCancel(sender:)))
        let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickedDone(sender:)))
        
        self.navigationItem.leftBarButtonItem = btnCancel
        self.navigationItem.rightBarButtonItem = btnDone
    }
    @objc private func clickedCancel(sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc private func clickedDone(sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
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
