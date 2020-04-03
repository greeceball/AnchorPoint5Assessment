//
//  SearchableRecord.swift
//  AnchorPoint5Assessment
//
//  Created by Colby Harris on 4/3/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}

