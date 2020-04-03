//
//  ContactListTableViewController.swift
//  AnchorPoint5Assessment
//
//  Created by Colby Harris on 4/3/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    //MARK: - Outlets and properties
    
    
    var contact: Contact? {
        didSet {
            updateViews()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactController.shared.contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let contact = ContactController.shared.contacts[indexPath.row]
            ContactController.shared.deleteContact(contact: contact) { (success) in
                if success {
                    print("Deleted \(contact.name) from you contacts")
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? ContactDetailViewController else { return }
            let contact = ContactController.shared.contacts[indexPath.row]
            destinationVC.contactLandingPad = contact
        }
    }
    
    //MARK: - Helper Func's
    
    func updateViews() {
        guard let contact = contact else { return }
        
    }
    
    func fetchContacts() {
        ContactController.shared.fetchAllContacts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
