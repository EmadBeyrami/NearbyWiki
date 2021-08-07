//
//  PagesModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/4/21.
//

import Foundation

// MARK: - Pages Model
// Because the key is Changing with the request we have to make a customKeys to decode properly
struct PagesModel: CodablePro {
    var result: [String: PageDetailModel]?
    
    struct CustomCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        
        self.result = [String: PageDetailModel]()
        for key in container.allKeys {
            let value = try container.decode(PageDetailModel.self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
            self.result?[key.stringValue] = value
        }
    }
}
