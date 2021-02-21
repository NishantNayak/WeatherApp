//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 20/02/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherText: UILabel!
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var citySelected: City!
    var weatherDetailsViewModel: WeatherDetailsViewModel?
    var forecastArray: [Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherDetailsViewModel = WeatherDetailsViewModel()
        bindData()
        self.weatherDetailsViewModel?.saveCitySearch(city: self.citySelected)
        getDetails()
    }
    
    func bindData() {
        weatherDetailsViewModel?.cityWeatherDetails.bind(observer: { [weak self] (forecast) in
            self?.forecastArray = forecast ?? []
            let currentForecast = self?.forecastArray[0]
            DispatchQueue.main.async {
                self?.cityName.text = self?.citySelected.englishName
                self?.weatherText.text = currentForecast?.weatherText
                self?.weatherImage.image = UIImage(named: "\(currentForecast?.weatherIcon ?? 1).png")
                self?.temperatureText.text = "\(currentForecast?.temperature?.metric?.value ?? 0.0) \u{00B0}C"
                self?.timeLabel.text = self?.weatherDetailsViewModel?.getDateString(epoch: currentForecast?.epochTime)
            }
        })
    }
    
    func getDetails() {
        weatherDetailsViewModel?.getWeatherDetails(cityCode: self.citySelected.key ?? "")
    }
}
