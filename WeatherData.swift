//
//  WeatherData.swift
//  Clima
//
//  Created by Angelo Hudej on 21.04.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable { //Decodable for JSON
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
