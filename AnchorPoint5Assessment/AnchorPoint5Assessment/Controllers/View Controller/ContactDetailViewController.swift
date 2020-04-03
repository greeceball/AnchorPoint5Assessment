//
//  ContactDetailViewController.swift
//  AnchorPoint5Assessment
//
//  Created by Colby Harris on 4/3/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contactLandingPad: Contact? {
        didSet {
            if isViewLoaded { updateViews() }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    func updateViews() {
        guard let contact = contactLandingPad else { return }
        //nameTextField.text = contact.name
        //emailTextField.text = contact.email
        //phoneNumberTextField.text = contact.phoneNumber
        self.title = contact.name
    }

}
