//
//  DiscoverViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var discoverTableView: UITableView!
    var cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoverTableView.separatorStyle = .none
        loadCities()
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuVC?.currentIndex = 0
        self.present(menuVC!, animated: true, completion: nil)
    }
    
    func loadCities() {
        let city1 = City(name: "Le Cap", price: 497, imageName: "desert")
        cities.append(city1)
        let city2 = City(name: "Port-Louis", price: 1099, imageName: "boat-largepic")
        cities.append(city2)
        let city3 = City(name: "Port-Jack", price: 558, imageName: "view-from-boat")
        cities.append(city3)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverTableViewCell") as? DiscoverTableViewCell else {
            fatalError("Could not instantiate cell")
        }
        let currentCity = cities[indexPath.row]
        cell.cityLabel.text = currentCity.name
        cell.priceLabel.text = currentCity.price
        cell.coverImageView.image = currentCity.image
        
        return cell
    }

}
