//
//  WikiStringsBuilder.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/3/21.
//

import Foundation

// MARK: - Wiki Query String type builder
// as can be seen most of all the multipleValue queries are seperated by a single '|' (pipe line).
// this builder will generate these type of strings
// - e.g: info|description|images
// for more information check: https://www.mediawiki.org/wiki/API:Nearby_places_viewer
class WikiStringsBuilder {
    
    enum Items: String {
        case info
        case description
        case pageimages
    }
    
    /**
     This will `convert [items] to a single string`
     # USE
     ```
     let stringBuilder = WikiStringsBuilder()
     return stringBuilder.setProps([items]])
     ```
     - Parameter: `[Items]`
     - Returns: `"String"`
     */
    
    func setProps(_ items: [Items]) -> String {
        var settedProps: String = ""
        items.forEach { item in
            settedProps += "|"
            settedProps.append(item.rawValue)
        }
        return String(settedProps.dropFirst())
    }
}
