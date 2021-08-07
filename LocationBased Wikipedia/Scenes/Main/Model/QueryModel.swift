//
//  QueryModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation

// MARK: - Query
struct QueryModel: Codable {
    let geosearch: [GeosearchModel]?
}
