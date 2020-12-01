//
//  CoronaModel.swift
//  StaySafe
//
//  Created by knight on 11/27/20.
//

import Foundation


struct Root : Decodable {
    let objectIdFieldName: String
    let uniqueIdField: uniqueIdField
    let globalIdFieldName: String?
    // let geometryProperties: geometryProperties
    let spatialReference: spatialReference
    let fields: [fields]
    let features: [features]
}

struct uniqueIdField: Decodable {
    let name: String
    let isSystemMaintained: Bool
}

struct geometryProperties: Decodable {
    let shapeAreaFieldName: String?
    let shapeLengthFieldName: String?
    let units: String?
    
    enum CodingKeys: String, CodingKey {
        case shapeAreaFieldName = "shapeAreaFieldName"
        case shapeLengthFieldName = "shapeLengthFieldName"
        case units = "units"
    }
}

struct spatialReference: Decodable {
    let wkid: Int
    let latestWkid: Int
}

struct fields: Decodable {
    let name: String
    let type: String
    let alias: String
    let sqlType: String
}

struct features: Decodable {
    let attributes: attributes
    
    struct attributes: Decodable {
        var last_update: String?
        var recovered: Int?
        var county: String?
        var cases_per_100k: Float?
        var cases: Int?
        var ade: Int?
        
        enum CodingKeys: String, CodingKey {
            case last_update = "last_update"
            case recovered = "recovered"
            case county = "county"
            case cases_per_100k = "cases_per_100k"
            case cases = "cases"
            case ade = "ade"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            last_update = try container.decodeIfPresent(String.self, forKey: .last_update)
            recovered = try container.decodeIfPresent(Int.self, forKey: .recovered)
            county = try container.decode(String.self, forKey: .county)
            cases_per_100k = try container.decodeIfPresent(Float.self, forKey: .cases_per_100k)
            cases = try container.decodeIfPresent(Int.self, forKey: .cases)
            ade = try container.decodeIfPresent(Int.self, forKey: .ade)
        }
    }
}

