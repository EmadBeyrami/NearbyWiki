//
//  BaseModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let batchcomplete: String?
    let query: T?
}
