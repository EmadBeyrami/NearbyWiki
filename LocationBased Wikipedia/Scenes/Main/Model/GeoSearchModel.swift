//
//  GeoSearchModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation

// MARK: - Geosearch
struct GeosearchModel: Codable {
    let pageid, ns: Int?
    let title: String?
    let lat, lon, dist: Double?
    let primary: String?
}
