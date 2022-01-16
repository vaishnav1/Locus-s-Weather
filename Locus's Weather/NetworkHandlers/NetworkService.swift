//
//  NetworkService.swift
//  Locus's Weather
//
//  Created by vaishnav.chidambar on 15/01/22.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/"
    let apiKey = "0f5de061ea46e9f11ca567c8cc220ee1"
    
    let session = URLSession(configuration: .default)
    
    func getWeatherForecast(cityName: String, onSuccess: @escaping (WeatherResponseModel) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: baseUrl + "weather?q=" + "\(cityName)&" + "appid=\(apiKey)") else {
            onError("Error")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("Response is \(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
}
