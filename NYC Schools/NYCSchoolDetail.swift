//
//  NYCSchoolDetail.swift
//  NYC Schools
//
//  Created by Brian Makuch on 9/26/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import Foundation

struct NYCSchoolDetail: Codable {
    var id: String            = " "
    var name: String          = " "
    var neighborhood: String  = " "
    var summary: String       = " "
    
    enum CodingKeys:String,CodingKey
    {
        case id = "dbn"
        case name = "school_name"
        case neighborhood
        case summary = "overview_paragraph"
    }
}
