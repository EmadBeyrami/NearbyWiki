//
//  DirectionBaseModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

// MARK: - Base
struct DirectionBaseModel: Codable {
    let geocodedWaypoints: [GeocodedWaypoint]
    let routes: [Route]

    enum CodingKeys: String, CodingKey {
        case geocodedWaypoints = "geocoded_waypoints"
        case routes
    }
}

// MARK: - GeocodedWaypoint
struct GeocodedWaypoint: Codable {
    let geocoderStatus, placeID: String
    let types: [String]
    let partialMatch: Bool?

    enum CodingKeys: String, CodingKey {
        case geocoderStatus = "geocoder_status"
        case placeID = "place_id"
        case types
        case partialMatch = "partial_match"
    }
}

// MARK: - Route
struct Route: Codable {
    let bounds: Bounds
    let copyrights: String
    let legs: [Leg]
}

// MARK: - Bounds
struct Bounds: Codable {
    let northeast, southwest: Northeast
}

// MARK: - Northeast
struct Northeast: Codable {
    let lat, lng: Double
}

// MARK: - Leg
struct Leg: Codable {
    let distance, duration: Distance
    let endAddress: String
    let endLocation: Northeast
    let startAddress: String
    let startLocation: Northeast

    enum CodingKeys: String, CodingKey {
        case distance, duration
        case endAddress = "end_address"
        case endLocation = "end_location"
        case startAddress = "start_address"
        case startLocation = "start_location"
    }
}

// MARK: - Distance
struct Distance: Codable {
    let text: String
    let value: Int
}
