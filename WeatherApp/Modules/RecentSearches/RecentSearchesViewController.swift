//
//  RecentSearchesViewController.swift
//  WeatherApp
//
//  Created by NINAYA-BLRM20 on 21/02/21.
//

import UIKit

class RecentSearchesViewController: UIViewController {

    @IBOutlet weak var recentSearchesTableView: UITableView!
    
    var recentCitiesArray: [City] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let cityArray = LocalDataManager.recentCities {
            self.recentCitiesArray = cityArray
            self.recentSearchesTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "recentSearchesDetails") {
            if let destination = segue.destination as? WeatherDetailsViewController {
                let city = sender as! City
                destination.citySelected = city
            }
        }
    }

}

extension RecentSearchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recentCitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentCitiesCell", for: indexPath)
        let city = recentCitiesArray[indexPath.row]
        cell.textLabel?.text = city.englishName
        cell.detailTextLabel?.text = "\(city.administrativeArea?.englishName ?? ""), \(city.country?.englishName ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = recentCitiesArray[indexPath.row]
        self.performSegue(withIdentifier: "recentSearchesDetails", sender: city)
    }
}
