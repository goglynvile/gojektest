//
//  ContactDetailTableViewController.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import UIKit

class ContactDetailTableViewController: UITableViewController {

    // MARK: IBOutlets
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    // MARK: Public variables
    weak var contactViewModel: ContactViewModel?
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ContactDetailHeaderView.nib, forHeaderFooterViewReuseIdentifier: ContactDetailHeaderView.reuseIdentifier)
        self.addEditButton()
        self.updateUI()
        self.fetchContact()
        
    }
    // MARK: Private methods
    private func addEditButton() {
        let btnEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(clickedEdit(sender:)))
        self.navigationItem.rightBarButtonItem = btnEdit
    }
    @objc func clickedEdit(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showEdit", sender: sender)
    }
    private func fetchContact() {
        guard let id = contactViewModel?.contact.id else { return }
        DataManager.shared.fetchContact(for: id) { (result, error) in
            print("result: \(result)")
            if let result = result {
                self.contactViewModel?.contact.update(item: result)
                
                self.updateUI()
            }
            else {
                
            }
        }
    }
    private func updateUI() {
        DispatchQueue.main.async {
            self.lblMobile.text = self.contactViewModel?.contact.phoneNumber
            self.lblEmail.text = self.contactViewModel?.contact.email
        }
    }
    
    // MARK: Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactEditViewController = segue.destination as? ContactUpdateTableViewController
        contactEditViewController?.delegate = self
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
extension ContactDetailTableViewController: ContactUpdateViewControllerDelegate {
    
    func didCancelUpdate() {
        self.dismiss(animated: true, completion: nil)
    }
    func didEditContact(contactViewModel: ContactViewModel) {
        self.updateUI()
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    func didAddContact(contactViewModel: ContactViewModel) {
        self.dismiss(animated: true, completion: nil)
    }
}
