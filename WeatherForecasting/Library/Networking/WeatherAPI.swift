//
//  ForecastAPI.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum WeatherAPI {
    case forecastCoordinates(latitude: Double, longitude: Double)
    case weatherCoordinates(latitude: Double, longitude: Double)
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

extension WeatherAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: AppNetworkEnvironment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .forecastCoordinates:
            return "/forecast"
        case .weatherCoordinates:
            return "/weather"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .forecastCoordinates(let latitude, let longitude), .weatherCoordinates(let latitude, let longitude):
            return .requestParameters(parameters: ["lat": "\(latitude)", "lon": "\(longitude)", "appid": AppNetworkEnvironment.appID, "units" : "metric" ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
