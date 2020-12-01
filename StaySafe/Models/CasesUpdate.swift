//
//  CasesUpdate.swift
//  StaySafe
//
//  Created by knight on 11/27/20.
//

import Foundation


struct CasesUpdate {
    var cases: Int?
    var last_update: String = ""
    var county: String = ""
    var status: String?
        
    init(cases: Int, last_update: String, county: String, status: String) {
        self.cases = cases
        self.last_update = last_update
        self.county = county
        self.status = status
    }
}
