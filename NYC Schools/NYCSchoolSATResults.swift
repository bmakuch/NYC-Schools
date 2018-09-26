//
//  NYCSchoolSATResults.swift
//  NYC Schools
//
//  Created by Brian Makuch on 9/25/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import Foundation

struct NYCSchoolSATResults: Codable {
    var id: String              = ""
    var name: String            = ""
    var numTakers: String       = ""
    var avgReadingScore: String = ""
    var avgMathScore: String    = ""
    var avgWritingScore: String = ""
    
    
    enum CodingKeys:String,CodingKey
    {
        case id = "dbn"
        case name = "school_name"
        case numTakers = "num_of_sat_test_takers"
        case avgReadingScore = "sat_critical_reading_avg_score"
        case avgMathScore = "sat_math_avg_score"
        case avgWritingScore = "sat_writing_avg_score"
    }
}
