//
//  ViewController.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 20/02/21.
//

import UIKit

class WeatherSearchViewController: UIViewController {

    @IBOutlet weak var weatherSearchTableView: UITableView!
    
    var weatherSearchViewModel: WeatherSearchViewModel?
    var cityArray: [City] = []
    var currentLocation: (String,String) = ("","")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Weather Details"
        let rightSideOptionButton = UIBarButtonItem()
        rightSideOptionButton.title = "Recent"
        rightSideOptionButton.target = self
        rightSideOptionButton.action = #selector(recentSearchesClicked(sender:))
        self.navigationItem.rightBarButtonItem = rightSideOptionButton
        self.weatherSearchViewModel = WeatherSearchViewModel()
        bindData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.weatherSearchViewModel?.getCurrentLocation()
    }
    
    func bindData() {
        weatherSearchViewModel?.cities.bind(observer: { [weak self] (cities) in
            self?.cityArray = cities ?? []
            DispatchQueue.main.async {
                self?.weatherSearchTableView.reloadData()
            }
        })
        weatherSearchViewModel?.location.bind(observer: { [weak self] (location) in
            self?.currentLocation = location ?? ("","")
            self?.weatherSearchViewModel?.getCityWithLocation(coordinate: self?.currentLocation ?? ("",""))
        })
        weatherSearchViewModel?.fetchingStatus.bind(observer: { (status) in
            if let activityStatus = status {
                if activityStatus {
                    DispatchQueue.main.async {
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        
                    }
                }
            }
        })
    }
    
    @objc func recentSearchesClicked(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "recentSearchesSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "weatherDetailsSegue") {
            if let destination = segue.destination as? WeatherDetailsViewController {
                let city = sender as! City
                destination.citySelected = city
            }
        }
    }
}

extension WeatherSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchController)
        perform(#selector(self.reload(_:)), with: searchController, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            self.weatherSearchViewModel?.getCurrentLocation()
            return
        }

        weatherSearchViewModel?.getCitiesWithText(cityName: query)
    }
}

extension WeatherSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell", for: indexPath)
        let city = cityArray[indexPath.row]
        cell.textLabel?.text = city.englishName
        cell.detailTextLabel?.text = "\(city.administrativeArea?.englishName ?? ""), \(city.country?.englishName ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityArray[indexPath.row]
        self.performSegue(withIdentifier: "weatherDetailsSegue", sender: city)
    }
}
