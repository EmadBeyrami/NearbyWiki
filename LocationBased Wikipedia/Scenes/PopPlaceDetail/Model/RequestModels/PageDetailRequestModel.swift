//
//  PageDetailRequestModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/3/21.
//

import Foundation

struct PageDetailRequestModel: CodablePro {
    
    // MARK: ⚠️ Warning ⚠️: remember to use WikiStringBuilder for multiple value queries
    // in this request model Prop Items are one of them
    var action, format: String?
    var propItems: String?
    var pageids: String?
    
    enum CodingKeys: String, CodingKey {
        case action, format, pageids
        case propItems = "prop"
    }
}
