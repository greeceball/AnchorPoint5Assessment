//
//  ContactDetailViewController.swift
//  AnchorPoint5Assessment
//
//  Created by Colby Harris on 4/3/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - Properties
    var contactLandingPad: Contact? {
        didSet {
            if isViewLoaded { updateViews() }
        }
    }
    
    //MARK: - LifeCycle func's
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Helper Func's
    func updateViews() {
        guard let contact = contactLandingPad else { return }
        nameTextField.text = contact.name
        emailTextField.text = contact.email
        phoneNumberTextField.text = contact.phoneNumber
        self.title = contact.name
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty, let email = emailTextField.text, let phoneNumber = phoneNumberTextField.text else { return }
        if let contact = self.contactLandingPad {
            contact.name = name
            contact.phoneNumber = phoneNumber
            contact.email = email
            self.title = contact.name
            ContactController.shared.updateContact(contact: contact) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            ContactController.shared.create(name: name, email: email, phoneNumber: phoneNumber) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }    
}
