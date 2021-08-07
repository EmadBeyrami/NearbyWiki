//
//  UserDefaultsPropertyWrapper+Extensions.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation
/*
 
 this is available on my `GitHub`
 this is a property wrapper to make saving data in UserDefaults way easier
 
 */

// Responsible for UserDefault of App
@propertyWrapper
struct UserDefault<T> {
    let key: UserDefaultsConfig.UserDefaultsKey
    let defaultValue: T

    init(_ key: UserDefaultsConfig.UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
