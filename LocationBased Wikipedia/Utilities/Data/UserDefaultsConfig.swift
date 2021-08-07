//
//  UserDefaultsConfig.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation

struct UserDefaultsConfig {
    
    enum UserDefaultsKey: String {
        case appleLanguages  = "AppleLanguages"
        case currentLanguage
        case googleAPIToken
    }
    
    @UserDefault(.currentLanguage, defaultValue: "en")
    static var currentLanguage: String
    
    @UserDefault(.appleLanguages, defaultValue: ["en"])
    static var appleLanguage: [String]
    
    @UserDefault(.googleAPIToken, defaultValue: "AIzaSyAcQ5g8hsAxdwvUImaZArU6wRvf8RfsWSc")
    static var googleAPIToken: String
    
    static func clearUserDefaultFor(_ key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func clearAllUserDefault() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()
    }
}
