//
//  LocationService.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 16/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import CoreLocation
import RxCoreLocation
import RxSwift
import MapKit

class LocationService: NSObject {
    
    let disposeBag = DisposeBag()
    
    enum Result<T> {
        case sucess(T)
        case fail
    }
    
    static let shared = LocationService()
    var locationManager: CLLocationManager
    
    private override init(){
        locationManager = CLLocationManager()
    }
    
    func requestLocation(completionHandler: @escaping (Result<(latitude: CLLocationDegrees, loginditude: CLLocationDegrees)>) -> ()) {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        locationManager.rx.placemark.subscribe(onNext: { placemark in
            
            guard let location = placemark.location else {
                return completionHandler(.fail)
            }
            completionHandler(.sucess((location.coordinate.latitude,location.coordinate.longitude)))
        })
        .disposed(by: disposeBag)
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func getContryAndCityWith(longitude: Double, latitude: Double) -> String {
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        var locationString = ""
        
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return  }
            locationString = city + ", " + country
        }
        return locationString
    }
    
}

