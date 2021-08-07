//
//  BaseAPIs.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

enum BaseAPIs {
    case googleMaps
    case wikipedia
    
    private struct InfoPlistKey {
        static let baseWikiAPIURL = "BaseWikiAPIURL"
        static let baseGoogleMapAPIURL = "BaseGoogleMapAPIURL"
    }
    
    var url: String {
        switch self {
        case .googleMaps:
            return Bundle.main.info(for: InfoPlistKey.baseGoogleMapAPIURL)!
            // return "https://maps.googleapis.com"
        case .wikipedia:
            return Bundle.main.info(for: InfoPlistKey.baseWikiAPIURL)!
            // return "https://en.wikipedia.org/w/api.php"
        }
    }
}
