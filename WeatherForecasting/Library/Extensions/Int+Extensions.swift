//
//  Int+Extension.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 18/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

extension Int {
    
    enum DateFormat: String {
        case dayWeek = "EEEE"
        case hour = "HH:mm"
    }
    
    func getDateInFormat(_ dateFormat: DateFormat = .dayWeek) -> String {
        let date = NSDate(timeIntervalSince1970: Double(self))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat.rawValue
        return dayTimePeriodFormatter.string(from: date as Date)
    }
}
