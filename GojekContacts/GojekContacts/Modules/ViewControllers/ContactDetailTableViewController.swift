//
//  ContactDetailTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {

    var contactViewModel: ContactViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ContactDetailHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        self.addEditButton()
    }
    // MARK: Private methods
    private func addEditButton() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clickedEdit(sender:)))
        self.navigationItem.rightBarButtonItem = editButton
    }
    @objc func clickedEdit(sender: UIBarButtonItem) {
        
    }
    
    // MARK: TableView delegate/datasource
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ContactDetailHeaderView
        headerView?.contactViewModel = contactViewModel
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 340
    }
}
