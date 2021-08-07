//
//  LocalizedStrings.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation

// We can also using swiftgen for generating string files
enum LocalizedStrings: String {
    
    case locationError
    case nearbyArticles = "Nearby Articles"
    case getThere = "Get there"
    case pageIdNotValid = "Page ID is not Valid"
    case routeSuggestion = "Route suggestions"
    case couldntFindDest = "Destination Couldn't found"
    case tryagain = "Try again"
    case error = "Error"
    case ok = "OK"

    var value: String {
        return localized(key: self.rawValue)
    }
    
    private func localized(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
