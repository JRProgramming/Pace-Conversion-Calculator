//
//  distanceUnit.swift
//  Pace Conversion Calculator
//
//  Created by Johnny Ramirez on 8/25/18.
//  Copyright © 2018 Johnny Ramirez. All rights reserved.
//

import Foundation

enum distanceUnit: String {
    case miles
    case kilometers
    var index: Int {
        switch self {
        case .miles: return 0
        case .kilometers: return 1
        }
    }
}
