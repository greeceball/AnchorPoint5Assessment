//
//  ContactController.swift
//  AnchorPoint5Assessment
//
//  Created by Colby Harris on 4/3/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import CloudKit

class ContactController {
    
    //MARK: - Properties
    static let shared = ContactController()
    let publicDB = CKContainer.default().publicCloudDatabase
    var contacts: [Contact] = []
    
    //MARK: - CRUD Functions
    //MARK: - Create
    func create(name: String, email: String, phoneNumber: String, completion: @escaping (Bool) -> Void) {
        let newContact = Contact(name: name, email: email, phoneNumber: phoneNumber)
        let newRecord = CKRecord(contact: newContact)
        
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print(error.localizedDescription + "---> \(error)")
                completion(false)
                return
            }
            guard let record = record, let contact = Contact(record: record) else { completion(false); return }
            self.contacts.append(contact)
            completion(true)
        }
    }
    
    //MARK: - Read
    func fetchAllContacts(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ConstantContact.TypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription + "---> \(error)")
                completion(false)
                return
            }
            guard let records = records else { completion(false); return }
            let contacts: [Contact] = records.compactMap({Contact(record: $0)})
            self.contacts = contacts
            completion(true)
            return
        }
    }
    
    //MARK: - Update
    func updateContact(contact: Contact, completion: @escaping (Bool) -> Void) {
        let records = CKRecord(contact: contact)
        let operation = CKModifyRecordsOperation(recordsToSave: [records])
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.queuePriority = .high
        operation.completionBlock = {
            completion(true)
            print("Contact Updated")
        }
        publicDB.add(operation)
    }
    
    //MARK: - Delete
    func deleteContact(contact: Contact, completion: @escaping(Bool) -> Void) {
        publicDB.delete(withRecordID: contact.ckRecordID) { (record, error) in
            if let error = error {
                print(error.localizedDescription + "---> \(error)")
                completion(false)
                return
            }
            if let _ = record {
                guard let index = self.contacts.firstIndex(of: contact) else { completion(false); return }
                self.contacts.remove(at: index)
                completion(true)
            }
        }
    }
}
