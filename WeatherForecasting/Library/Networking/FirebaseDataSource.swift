//
//  FirebaseDataSource.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 30/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDataSource {
    
    private var dataBaseReference: DatabaseReference!
    
    func setDataBaseReference() {
        dataBaseReference = Database.database().reference().child("forecasts");
    }
    
    func addForecast(with model: TodayModel, latitude: Double, longitude: Double) {
        let key = dataBaseReference.childByAutoId().key
        
        let forecast = ["id" : key,
                        "latitude" : String(latitude),
                        "longitude" : String(longitude),
                        "temperature": String(format:"%.2f", (model.main?.temp) ?? 0),
                        "weather" : model.weather?.first?.main,
                        "windSpeed" : String(format:"%.2f", (model.wind?.speed) ?? 0),
                        "windDirection" : String(model.wind?.deg ?? 0)]
        dataBaseReference.child(key!).setValue(forecast)
    }
    
}
