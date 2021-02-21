//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 20/02/21.
//

import Foundation

class WeatherDetailsViewModel {
    
    var cityWeatherDetails = Bindable<[Forecast]>()
    var fetchingStatus = Bindable<Bool>()
    
    func getWeatherDetails(cityCode: String) {
        self.fetchingStatus.value = true
        NetworkManager.sharedManager.getDailyForecastForCity(cityCode: cityCode) { [weak self] (forecasts) in
            self?.fetchingStatus.value = false
            self?.cityWeatherDetails.value = forecasts
        }
    }
    
    func saveCitySearch(city:City) {
        var recentCityArray = [City]()
        if let cityArray = LocalDataManager.recentCities {
            recentCityArray = cityArray
            for (index, cityItem) in recentCityArray.enumerated() {
                if (cityItem.key == city.key) {
                    recentCityArray.remove(at: index)
                    break
                }
            }
            
            if (recentCityArray.count == 5) {
                recentCityArray.remove(at: 4)
            }
        }
        recentCityArray.insert(city, at: 0)
        LocalDataManager.recentCities = recentCityArray
    }
    
    func getDateString(epoch: Double?) -> String {
        var localDate = ""
        if let timeResult = epoch {
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            localDate = dateFormatter.string(from: date)
        }
        return localDate
    }
}
