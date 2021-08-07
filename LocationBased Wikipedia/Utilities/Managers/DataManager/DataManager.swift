//
//  DataManager.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

class DataManager {

    static var shared: DataManager = DataManager()
    
    private init () {
        self.googleMapAccessToken   = UserDefaultsConfig.googleAPIToken
    }
    
    var googleMapAccessToken: String! {
        didSet {
            UserDefaultsConfig.googleAPIToken = googleMapAccessToken
        }
    }
}
