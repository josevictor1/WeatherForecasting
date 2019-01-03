//
//  ErrorType.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case locationError = "We could not find your location"
    case requestError = "Service temporarily unavailable. Your request could not be completed."
    case internetError = "There is no Internet connection"
}
