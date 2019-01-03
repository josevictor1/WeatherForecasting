//
//  ForecastViewModel.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import RxDataSources

struct ForecastViewModel {
    let weather: String
    let timePeriod: String
    let temperature: String
    let icon: String
}

struct SectionOfCustomData {
    var headerTitle: String
    var items: [ForecastViewModel]
}

extension SectionOfCustomData: SectionModelType {
    
    init(original: SectionOfCustomData, items: [ForecastViewModel]) {
        self = original
        self.items = items
    }
}
