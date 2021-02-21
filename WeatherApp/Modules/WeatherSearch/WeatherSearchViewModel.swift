//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 20/02/21.
//

import Foundation
import CoreLocation

class WeatherSearchViewModel: NSObject {
    
    var cities = Bindable<[City]>()
    var location = Bindable<(String,String)>()
    var fetchingStatus = Bindable<Bool>()
    var locationManager:CLLocationManager!
    
    func getCitiesWithText(cityName: String) {
        self.fetchingStatus.value = true
        NetworkManager.sharedManager.getCitiesFromString(searchText: cityName) { [weak self] (cities) in
            self?.fetchingStatus.value = false
            self?.cities.value = cities
        }
    }
    
    func getCityWithLocation(coordinate: (String,String)) {
        self.fetchingStatus.value = true
        NetworkManager.sharedManager.getCityFromLocation(coordinate: coordinate) { [weak self] (city) in
            self?.fetchingStatus.value = false
            var cityArray = [City]()
            cityArray.append(city)
            self?.cities.value = cityArray
        }
    }
    
    func getCurrentLocation() {
        if let location = LocalDataManager.currentLocation {
            self.location.value = getLocationTuple(location: location)
            return
        }
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
                
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func getLocationTuple(location: String) -> (String,String) {
        let locationArr = location.components(separatedBy: "&")
        return("\(locationArr[0])","\(locationArr[1])")
    }
}

extension WeatherSearchViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        manager.stopUpdatingLocation()
        
        guard LocalDataManager.currentLocation != nil else {
            let location = "\(userLocation.coordinate.latitude)&\(userLocation.coordinate.longitude)"
            LocalDataManager.currentLocation = location
            self.location.value = ("\(userLocation.coordinate.latitude)","\(userLocation.coordinate.longitude)")
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        // fallback to Nagpur if location cannot be retrieved
        self.location.value = ("21.1458","79.0882")
    }
    
}
