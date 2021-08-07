//
//  NearbyArticlesRequestModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation

struct NearbyArticlesRequestModel: CodablePro {
    var action, format: String?
    var list: String?
    var gscoord: String?
    var gsradius, gslimit: Int?
}
