//
//  Float+Extensions.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 31/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension Float {
    func compassDirection() -> String {
        if self < 0 { return "" }
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = (Int(self)/45) & 7
        return directions[index]
    }
}
