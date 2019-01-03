//
//  TodayModel.swift
//  TodayForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//

import Foundation

struct TodayModel : Codable {
    
    let base : String?
    let clouds : TodayCloud?
    let cod : Int?
    let coord : TodayCoord?
    let dt : Int?
    let id : Int?
    let main : TodayMain?
    let name : String?
    let rain: Rain?
    let sys : TodaySy?
    let visibility : Int?
    let weather : [TodayToday]?
    let wind : TodayWind?
    
    enum CodingKeys: String, CodingKey {
        case base = "base"
        case clouds = "clouds"
        case cod = "cod"
        case coord = "coord"
        case dt = "dt"
        case id = "id"
        case main = "main"
        case name = "name"
        case sys = "sys"
        case rain = "rain"
        case visibility = "visibility"
        case weather = "weather"
        case wind = "wind"
    }
}

struct TodayWind : Codable {
    
    let deg : Float?
    let gust : Float?
    let speed : Float?
    
    enum CodingKeys: String, CodingKey {
        case deg = "deg"
        case gust = "gust"
        case speed = "speed"
    }
}

struct TodayToday : Codable {
    
    let descriptionField : String?
    let icon : String?
    let id : Int?
    let main : String?
    
    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case icon = "icon"
        case id = "id"
        case main = "main"
    }
}

struct TodaySy : Codable {
    
    let country : String?
    let id : Int?
    let message : Float?
    let sunrise : Int?
    let sunset : Int?
    let type : Int?
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case id = "id"
        case message = "message"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case type = "type"
    }

}

struct TodayMain : Codable {
    
    let humidity : Float?
    let pressure : Float?
    let temp : Float?
    let tempMax : Float?
    let tempMin : Float?
    
    enum CodingKeys: String, CodingKey {
        case humidity = "humidity"
        case pressure = "pressure"
        case temp = "temp"
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

struct TodayCoord : Codable {
    
    let lat : Float?
    let lon : Float?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct TodayCloud : Codable {
    
    let all : Float?
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }

}


