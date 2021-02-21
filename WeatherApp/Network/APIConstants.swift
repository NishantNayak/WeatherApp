//
//  APIConstants.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 21/02/21.
//

import Foundation

struct APIConstants {
    static var baseUrl = "http://dataservice.accuweather.com/"
    static var apiKey = "2H7M5oY4WqRIUBPRoMUaNGbRO8gqAG9E"
    
    struct Endpoints {
        static var getCityByText = "locations/v1/cities/search"
        static var getCityByLocation = "locations/v1/cities/geoposition/search"
        static var getweatherDetails = "currentconditions/v1/"
    }
}
