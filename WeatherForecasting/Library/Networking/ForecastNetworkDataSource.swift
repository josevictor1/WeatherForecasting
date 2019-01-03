//
//  ForacastService.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import CoreLocation
import Moya
import RxSwift
import RxCocoa
import Alamofire

protocol ForecastNetworkDelegate: class {
    func forecastRequest(with result: [SectionOfCustomData])
    func forecastRequest(with error: ErrorType)
}

protocol TodayNetworkDelegate: class {
    func weatherRequest(with result: TodayViewModel)
    func weatherRequest(with error: ErrorType)
}

class ForecastNetworkDataSource {
    
    weak var outputForecastNetwork: ForecastNetworkDelegate?
    weak var outputTodayNetwork: TodayNetworkDelegate?
    
    var provider = MoyaProvider<WeatherAPI>()
    var firebaseDataSource = FirebaseDataSource()
    let locationService = LocationService.shared
    
    init(provider: MoyaProvider<WeatherAPI> = MoyaProvider(plugins: [NetworkLoggerPlugin(verbose: true)])) {
        self.provider = provider
    }
    
    func requestForecastWeather() {
        if isConnectedToInternet() {
            locationService.requestLocation { (result) in
                switch result {
                case .sucess(let coordinates):
                    _ = self.requestForecast(latitude: coordinates.latitude, longitude: coordinates.loginditude).subscribe { (event) in
                        switch event {
                        case .success(let result):
                            self.outputForecastNetwork?.forecastRequest(with: self.fillForecastViewModel(with: result))
                        case .error(_):
                            self.outputForecastNetwork?.forecastRequest(with: .requestError)
                        }
                    }
                    break
                case .fail:
                    self.outputForecastNetwork?.forecastRequest(with: .locationError)
                }
            }
        } else {
            self.outputForecastNetwork?.forecastRequest(with: .internetError)
        }
    }
    
    func requestTodayWeather() {
        if isConnectedToInternet() {
            locationService.requestLocation { (result) in
                switch result {
                case .sucess(let coordinates):
                    _ = self.requestTodayWeather(latitude: coordinates.latitude, longitude: coordinates.loginditude).subscribe { (event) in
                        switch event {
                        case .success(let result):
                            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.loginditude)
                            self.firebaseDataSource.setDataBaseReference()
                            self.firebaseDataSource.addForecast(with: result, latitude: coordinates.latitude, longitude: coordinates.loginditude)
                            self.locationService.fetchCityAndCountry(from: location) { city, country, error in
                                guard let city = city, let country = country, error == nil else { return  }
                                let locationString = city + ", " + country
                                self.outputTodayNetwork?.weatherRequest(with: self.fillTodayViewModel(with: result, location: locationString))
                            }
                        case .error(_):
                            self.outputTodayNetwork?.weatherRequest(with: .requestError)
                        }
                    }
                    break
                case .fail:
                    self.outputTodayNetwork?.weatherRequest(with: .locationError)
                }
            }
        } else {
            self.outputTodayNetwork?.weatherRequest(with: .internetError)
        }
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private func requestForecast(latitude: Double , longitude: Double) -> Single<ForecastModel> {
       return provider.rx.request(.forecastCoordinates(latitude: latitude, longitude: longitude))
            .filter(statusCode: 200)
            .retry(3)
            .map(ForecastModel.self)
            .catchError { error in
                throw error
            }
    }
    
    private func requestTodayWeather(latitude: Double , longitude: Double) -> Single<TodayModel> {
        return provider.rx.request(.weatherCoordinates(latitude: latitude, longitude: longitude))
            .filter(statusCode: 200)
            .retry(3)
            .map(TodayModel.self)
            .catchError { error in
                throw error
        }
    }
    
    private func fillForecastViewModel(with model: ForecastModel) -> [SectionOfCustomData] {
        var forecastViewModelList: [SectionOfCustomData] = []
        guard let objectList = model.list else {
            return []
        }
        objectList.enumerated().forEach { (offset, element) in
            if let dt = element.dt, let weather = element.weather, let main = element.main, !forecastViewModelList.contains(where: { (section) -> Bool in
                section.headerTitle == dt.getDateInFormat().uppercased() }) {
                forecastViewModelList.append(
                    SectionOfCustomData(
                        headerTitle: dt.getDateInFormat().uppercased() ,
                        items: [ForecastViewModel(weather: weather.first?.main?.rawValue ?? "",
                                                  timePeriod: dt.getDateInFormat(.hour),
                                                  temperature: String(format: "%.0f°",main.temp ?? 0),
                                                  icon: weather.first?.icon ?? "" )]))
            } else if let dt = element.dt, let weather = element.weather, let main = element.main, forecastViewModelList.count > 0 {
                forecastViewModelList[forecastViewModelList.count - 1].items
                    .append(ForecastViewModel(weather: weather.first?.main?.rawValue ?? "",
                                              timePeriod: dt.getDateInFormat(.hour),
                                              temperature: String(format: "%.0f°",main.temp ?? 0),
                                              icon: weather.first?.icon ?? ""))
            }
        }
        return forecastViewModelList
    }
    
    
    private func fillTodayViewModel(with model: TodayModel, location: String) -> TodayViewModel {
        
        if let wheather = model.weather, let main = wheather.first?.main, let icon = wheather.first?.icon, let temp = model.main?.temp, let humidity = model.main?.humidity, let pressure = model.main?.pressure, let windSpeed = model.wind?.speed, let windDirection = model.wind?.deg {
            let temperature = String(format:"%.0f", temp)
            var precipitation = "-"
            if let rain = model.rain?.the3H {
                precipitation = "\(rain) mm"
            } else if let rain = model.rain?.the1H {
                precipitation = "\(rain) mm"
            }
            return TodayViewModel(descriptionWeather: "\(temperature)°C | " + main,
                                    humidity: "\(humidity)%",
                                    icon: icon,
                                    location: location,
                                    precipitation: precipitation,
                                    pressure: "\(pressure) hPa",
                                    weather: main,
                                    wind: "\(Int(windSpeed * 3.6)) km/h",
                                    windDirection: windDirection.compassDirection())
        }
        
        return TodayViewModel(descriptionWeather: "-",
                              humidity: "-",
                              icon: "-",
                              location: "-",
                              precipitation: "-",
                              pressure: "-",
                              weather: "-",
                              wind: "-",
                              windDirection: "-")
    }
    
    
}
