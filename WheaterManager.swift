//
//  WheaterManager.swift
//  Clima
//
//  Created by Angelo Hudej on 20.04.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(_ error: Error?)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=c275824504b6e876b5c6258291f6b72f&units=metric&" //q=fritzens
    let weatherUrlCoordinates = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=c275824504b6e876b5c6258291f6b72f&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(CityName: String){
        let urlString = "\(weatherUrl)q=\(CityName)"
        self.performRequest(with: urlString)
    }
    
    func fetchWeatherCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherUrl)lat=\(latitude)&lon=\(longitude)"
        self.performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        
        //1. Create URL
        if let url = URL(string: urlString){
            
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give Session a Task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: city, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
        
}
