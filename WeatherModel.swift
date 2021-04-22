//
//  WeatherModel.swift
//  Clima
//
//  Created by Angelo Hudej on 21.04.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case _ where conditionId < 200:
            return "sunrise"
        case _ where conditionId < 232:
            return "cloud.bolt.fill"
        case _ where conditionId < 321:
            return "cloud.drizzle.fill"
        case _ where conditionId < 531:
            return "cloud.rain.fill"
        case _ where conditionId < 622:
            return "cloud.snow.fill"
        case _ where conditionId < 781:
            return "cloud.fog.fill"
        case 800:
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sunrise"
        }
    }
}
