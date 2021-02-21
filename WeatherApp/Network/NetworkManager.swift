//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 20/02/21.
//

import Foundation

class NetworkManager {
    
    static let sharedManager = NetworkManager()
    let headers = [
      "cache-control": "no-cache",
      "postman-token": "b1856aed-3c97-be60-dfd8-80d317450d72"
    ]
    
    private init() {        
    }
    
    func getCitiesFromString(searchText: String, callback: @escaping ([City]) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)\(APIConstants.Endpoints.getCityByText)?apikey=\(APIConstants.apiKey)&q=\(searchText)")!)
            
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        apiCall(request: request, callback: callback)
    }

    func getDailyForecastForCity(cityCode: String, callback: @escaping ([Forecast]) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)\(APIConstants.Endpoints.getweatherDetails)\(cityCode)?apikey=\(APIConstants.apiKey)")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        apiCall(request: request, callback: callback)
    }
    
    func getCityFromLocation(coordinate: (String,String), callback: @escaping (City) -> Void) {
        var request = URLRequest(url: URL(string: "\(APIConstants.baseUrl)\(APIConstants.Endpoints.getCityByLocation)?apikey=\(APIConstants.apiKey)&q=\(coordinate.0),\(coordinate.1)")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        apiCall(request: request, callback: callback)
    }
    
    func apiCall<T: Decodable>(request: URLRequest, callback: @escaping (T) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error.debugDescription)
          } else {
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                guard let cityData = data else {
                    print("Data Error!")
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let responseData = try decoder.decode(T.self, from: cityData)
                    callback(responseData)
                } catch let err {
                    print("decoding error: \(err)")
                }
            }
          }
        })
        dataTask.resume()
    }

}
