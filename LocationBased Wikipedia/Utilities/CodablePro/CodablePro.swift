//
//  CodablePro.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation

protocol CodablePro: Codable {
    typealias JSON = [String: Any]
    init?(data: Data)
    init?(_ json: String, using encoding: String.Encoding)
    var json: String? { get }
    var jsonData: Data? { get }
    func toDictionary() -> JSON?
    func convertToDictionary() -> Any?
    func toQueryString() -> String?
}

extension CodablePro {
    
    init?(data: Data) {
        do {
            let object = try JSONDecoder().decode(Self.self, from: data)
            self = object
        } catch {
            print("Parsing JSON Error From:", "\(Self.self)")
            print(error)
            return nil
        }
    }
    
    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func toDictionary() -> JSON? {
          // Encode the data
          if let jsonData = try? JSONEncoder().encode(self),
              // Create a dictionary from the data
             let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? JSON {
            return dict
        }
        return nil
    }
    
    func convertToDictionary() -> Any? {
        let text: String? = self.json
        guard text != nil else { return nil }
        if let data = text!.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func toQueryString() -> String? {
        guard let data = self.toDictionary() else { return nil }
        return data.queryString
    }
}

extension Dictionary {
    var queryString: String {
        var components = URLComponents()
            print(components.url!)
            components.queryItems = self.map {
                URLQueryItem(name: String(describing: $0), value: String(describing: $1))
            }
           return (components.url?.absoluteString)!
    }
}
