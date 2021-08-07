//
//  ImageModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/3/21.
//

import Foundation

// MARK: - Image List Model
typealias PageImageListModel = [PageImageModel]

// MARK: - Image Models
struct PageImageModel: CodablePro {
    let ns: Int?
    let title: String?
    let source: String
    let width, height: Int
}
