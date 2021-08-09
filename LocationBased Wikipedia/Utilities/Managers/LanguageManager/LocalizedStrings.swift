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
    case nearbyArticles = "Nearby_Articles"
    case getThere = "Get_there"
    case pageIdNotValid = "Page_Id_Not_Valid"
    case routeSuggestion = "Route_suggestions"
    case couldntFindDest = "cant_find_dest"
    case changeLang = "Change_Lang"
    case tryagain = "TryAgain"
    case error = "Error"
    case ok = "OK"
    case cancel

    var value: String {
        return localized(key: self.rawValue)
    }
    
    private func localized(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
