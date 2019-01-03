//
//  ForecastModel.swift
//  WeatherForecasting
//
//  Created by José Victor Pereira Costa on 17/12/18.
//  Copyright © 2018 José Victor Pereira Costa. All rights reserved.
//
// To parse the JSON, add this file to your project and do:
//
//   let forecastModel = try ForecastModel(json)

import Foundation

struct ForecastModel: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
}

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
    }
}

struct Coord: Codable {
    let lat: Double?
    let lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let rain: Rain?
    let sys: Sys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case rain = "rain"
        case sys = "sys"
        case dtTxt = "dt_txt"
    }
}

struct Clouds: Codable {
    let all: Int?
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct MainClass: Codable {
    let temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let seaLevel: Double?
    let grndLevel: Double?
    let humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }
}

struct Rain: Codable {
    let the1H: Double?
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
        case the3H = "3h"
    }
}

struct Sys: Codable {
    let pod: Pod?
    
    enum CodingKeys: String, CodingKey {
        case pod = "pod"
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

struct Weather: Codable {
    let id: Int?
    let main: MainEnum?
    let description: String?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}

// MARK: Convenience initializers and mutators

extension ForecastModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ForecastModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        cod: String?? = nil,
        message: Double?? = nil,
        cnt: Int?? = nil,
        list: [List]?? = nil,
        city: City?? = nil
        ) -> ForecastModel {
        return ForecastModel(
            cod: cod ?? self.cod,
            message: message ?? self.message,
            cnt: cnt ?? self.cnt,
            list: list ?? self.list,
            city: city ?? self.city
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension City {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(City.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        name: String?? = nil,
        coord: Coord?? = nil,
        country: String?? = nil,
        population: Int?? = nil
        ) -> City {
        return City(
            id: id ?? self.id,
            name: name ?? self.name,
            coord: coord ?? self.coord,
            country: country ?? self.country,
            population: population ?? self.population
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Coord {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Coord.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        lat: Double?? = nil,
        lon: Double?? = nil
        ) -> Coord {
        return Coord(
            lat: lat ?? self.lat,
            lon: lon ?? self.lon
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension List {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(List.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        dt: Int?? = nil,
        main: MainClass?? = nil,
        weather: [Weather]?? = nil,
        clouds: Clouds?? = nil,
        wind: Wind?? = nil,
        rain: Rain?? = nil,
        sys: Sys?? = nil,
        dtTxt: String?? = nil
        ) -> List {
        return List(
            dt: dt ?? self.dt,
            main: main ?? self.main,
            weather: weather ?? self.weather,
            clouds: clouds ?? self.clouds,
            wind: wind ?? self.wind,
            rain: rain ?? self.rain,
            sys: sys ?? self.sys,
            dtTxt: dtTxt ?? self.dtTxt
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Clouds {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Clouds.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        all: Int?? = nil
        ) -> Clouds {
        return Clouds(
            all: all ?? self.all
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension MainClass {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(MainClass.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        temp: Double?? = nil,
        tempMin: Double?? = nil,
        tempMax: Double?? = nil,
        pressure: Double?? = nil,
        seaLevel: Double?? = nil,
        grndLevel: Double?? = nil,
        humidity: Int?? = nil,
        tempKf: Double?? = nil
        ) -> MainClass {
        return MainClass(
            temp: temp ?? self.temp,
            tempMin: tempMin ?? self.tempMin,
            tempMax: tempMax ?? self.tempMax,
            pressure: pressure ?? self.pressure,
            seaLevel: seaLevel ?? self.seaLevel,
            grndLevel: grndLevel ?? self.grndLevel,
            humidity: humidity ?? self.humidity,
            tempKf: tempKf ?? self.tempKf
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Rain {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Rain.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(the1H: Double?? = nil,
        the3H: Double?? = nil
        ) -> Rain {
        return Rain(
            the1H: the1H ?? self.the1H,
            the3H: the3H ?? self.the3H
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Sys {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Sys.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        pod: Pod?? = nil
        ) -> Sys {
        return Sys(
            pod: pod ?? self.pod
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Weather {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Weather.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        main: MainEnum?? = nil,
        description: String?? = nil,
        icon: String?? = nil
        ) -> Weather {
        return Weather(
            id: id ?? self.id,
            main: main ?? self.main,
            description: description ?? self.description,
            icon: icon ?? self.icon
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Wind {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Wind.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        speed: Double?? = nil,
        deg: Double?? = nil
        ) -> Wind {
        return Wind(
            speed: speed ?? self.speed,
            deg: deg ?? self.deg
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
