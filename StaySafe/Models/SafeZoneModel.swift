//
//  SafeZoneModel.swift
//  StaySafe
//
//  Created by knight on 12/2/20.
//

import Foundation


struct SafeZone {
    var cases: String = ""
    var deaths: String?
    var last_update: String?
    var recovered: String?
    var cases_per_100k: Float?
    var county: String?
    var status: String = "" 
}
