//
//  CoreDataUtility.swift
//  NewsApp
//
//  Created by NINAYA-BLRM20 on 09/11/20.
//

import Foundation
import CoreLocation

class LocalDataManager {
    
    static let kRecentCities = "RecenCities"
    static let kCurrentLocation = "CurrentLocation"
    
    static var recentCities: [City]? {
        get {
            var rCities: [City]? = nil
            do {
                let cities = try UserDefaults.standard.getObject(forKey: kRecentCities, as: [City].self)
                rCities = cities
            } catch {
                print(error.localizedDescription)
            }
            return rCities
        }
        set(newValue) {
            do {
                try UserDefaults.standard.setObject(newValue, forKey: kRecentCities)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    static var currentLocation: String? {
        get {
            let location = UserDefaults.standard.object(forKey: kCurrentLocation)
            return location as? String
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: kCurrentLocation)
        }
    }
}

extension UserDefaults {
    
    func setObject<Object>(
        _ object: Object, forKey: String
    ) throws where Object: Encodable {
        
        let data = try JSONEncoder().encode(object)
        self.set(data, forKey: forKey)
    }
    
    func getObject<Object>(
        forKey: String, as type: Object.Type
    ) throws -> Object? where Object: Decodable {
        
        guard let data = self.data(forKey: forKey) else {
            return nil
        }
        return try JSONDecoder().decode(type, from: data)
    }
}
