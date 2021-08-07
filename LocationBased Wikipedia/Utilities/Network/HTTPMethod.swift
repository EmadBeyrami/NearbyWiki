//
//  HTTPMethod.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation

enum HTTPMethod {
    case get
    
    var rawStringValue: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
