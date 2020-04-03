//
//  Contact.swift
//  AnchorPoint5Assessment
//
//  Created by Colby Harris on 4/3/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import CloudKit

struct ConstantContact {
    
    static let TypeKey = "Contact"
    fileprivate static let NameKey = "name"
    fileprivate static let EmailKey = "email"
    fileprivate static let phoneKey = "phonenumber"
    
}

class Contact {
    
    var name: String
    var email: String
    var phoneNumber: String
    var ckRecordID: CKRecord.ID
    
    
    init(name: String, email: String, phoneNumber: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.ckRecordID = ckRecordID
        
    }
    
    convenience init?(record: CKRecord) {
           
           guard let name = record[ConstantContact.NameKey] as? String, let email = record[ConstantContact.EmailKey] as? String, let phoneNumber = record[ConstantContact.phoneKey] as? String else { return nil }
           
           self.init(name: name, email: email, phoneNumber: phoneNumber, ckRecordID: record.recordID)
       }
}

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ConstantContact.TypeKey, recordID: contact.ckRecordID)
        
        setValue(contact.name, forKey: ConstantContact.NameKey)
        setValue(contact.email, forKey: ConstantContact.EmailKey)
        setValue(contact.phoneNumber, forKey: ConstantContact.phoneKey)
    }
}

extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}
