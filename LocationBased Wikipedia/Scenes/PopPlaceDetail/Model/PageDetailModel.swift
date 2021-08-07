//
//  PageModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/4/21.
//

import Foundation

// MARK: Page Detail Model
/// this is `Page`
struct PageDetailModel: CodablePro {
    
    let pageid: Int?
    let ns: Int?
    let title, contentmodel, pagelanguage, pagelanguagehtmlcode: String?
    let pagelanguagedir: String?
    let touched: String?
    let lastrevid, length: Double?
    let articleDescription, descriptionsource: String?
    let images: PageImageListModel?
    let thumbnail: PageImageModel?
    let pageimage: String?

    enum CodingKeys: String, CodingKey {
        case pageid, ns, title, contentmodel, pagelanguage, pagelanguagehtmlcode, pagelanguagedir, touched, lastrevid, length
        case articleDescription = "description"
        case descriptionsource, images, thumbnail, pageimage
    }
}
