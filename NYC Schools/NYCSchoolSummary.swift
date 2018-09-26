//
//  NYCSchoolSummary.swift
//  NYC Schools
//
//  Created by Brian Makuch on 9/25/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import Foundation

struct NYCSchoolSummary: Codable {
    var id: String            = " "
    var name: String          = " "
    var neighborhood: String  = " "
    
    enum CodingKeys:String,CodingKey
    {
        case id = "dbn"
        case name = "school_name"
        case neighborhood
    }
}
