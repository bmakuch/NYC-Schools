//
//  DataResult.swift
//  NYC Schools
//
//  Created by Brian Makuch on 9/25/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import Foundation

enum DataResult<Value> {
    case success(Value)
    case failure(Error)
}
