//
//  AppEnvironment.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

import Foundation

struct AppNetworkEnvironment {
    
    static var baseURL: String {
        return "https://api.openweathermap.org/data/2.5"
    }
    
    static var appID: String {
        return "c600df1b39b954b080a9d9988f56e6d2"
    }
    
}
