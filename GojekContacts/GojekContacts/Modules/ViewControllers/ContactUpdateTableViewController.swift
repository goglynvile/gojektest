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
    
    private var tempImage: UIImage?
    private var tempImageUrl: String?
    
    // MARK: Public IBOutlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet var txtFields: [UITextField]!
    
    
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

        if !hasParameterError() {
            self.uploadImage()
        }
        else {
             self.showAlert(title: Constant.App.name, message: Constant.Text.allFields)
        }
       
    }
    
    // MARK: Private methods
    private func hasParameterError() -> Bool {
        var hasEmpty = false
    
        for txtField in self.txtFields {
            if txtField.text == nil || txtField.text?.isEmpty ?? true {
                txtField.layer.borderColor = UIColor.red.cgColor
                txtField.layer.borderWidth = 1
                hasEmpty = true
            }
            else {
                txtField.layer.borderColor = UIColor.clear.cgColor
                txtField.layer.borderWidth = 0
            }
        }
        if tempImage == nil {
            hasEmpty = true
        }
        return hasEmpty
    }
    private func getParameter() -> Parameters {
        
        var item = Parameters()
        item["first_name"] = self.txtFirstName.text
        item["last_name"] = self.txtLastName.text
        item["email"] = self.txtEmail.text
        item["phone_number"] = self.txtMobile.text
        item["profile_pic"] = self.tempImageUrl
    
        return item
    }
    
    private func addContact() {
        
        print("adding...\(self.getParameter())")
        DataManager.shared.addContact(item: self.getParameter()) { (result, error) in
            if let result = result {
                print("add result: \(result)")
                let contact = Contact(item: result)
                let cViewModel = ContactViewModel(contact: contact)
                self.delegate?.didAddContact(contactViewModel: cViewModel)
            }
            else {
                guard let error = error else { return }
                DispatchQueue.main.async {
                    self.showAlert(title: Constant.App.name, message: error)
                }
            }
        }
    }
    private func editContact() {
        
        guard let id = contactViewModel?.contact.id else { return }
        DataManager.shared.editContact(id: id, item: self.getParameter()) { (result, error) in
            if let result = result {
                print("edit result: \(result)")
                self.contactViewModel?.contact.update(item: result)
                self.delegate?.didEditContact(contactViewModel: self.contactViewModel!)
            }
            else {
                guard let error = error else { return }
                DispatchQueue.main.async {
                    self.showAlert(title: Constant.App.name, message: error)
                }
            }
        }
    }
    private func uploadImage() {
        if let temp = tempImage, let data = temp.jpegData(compressionQuality: 0.2) {
            DataManager.shared.uploadImage(data: data) { (result, error) in
                if result != nil {
                    
                    self.tempImageUrl = result
                    
                    DispatchQueue.main.async {
                        if self.isNew {
                            self.addContact()
                        }
                        else {
                            self.editContact()
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.showAlert(title: Constant.App.name, message: error)
                    }
                }
            }
        }
        
    }
    
    private func didSelectImage(image: UIImage?) {
        if let image = image {
            tempImage = image
            self.tableView.reloadData()
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
        headerView?.delegate = self
        headerView?.updateHeader(withImage: tempImage)
        return headerView
    }
}

extension ContactUpdateTableViewController: ContactEditHeaderViewDelegate {
    func didSelectPicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        self.present(pickerController, animated: true, completion: nil)
    }
}

extension ContactUpdateTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        self.didSelectImage(image: info[.editedImage] as? UIImage)
    }
}
extension ContactUpdateTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName {
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName {
            txtMobile.becomeFirstResponder()
        }
        else if textField == txtMobile {
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail {
            
            if !hasParameterError() {
                self.uploadImage()
            }
            else {
                self.showAlert(title: Constant.App.name, message: Constant.Text.allFields)
            }
        }
        
        return true
    }
}
