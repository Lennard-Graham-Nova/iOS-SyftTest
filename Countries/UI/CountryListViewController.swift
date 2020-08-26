//
//  CountryListViewController.swift
//  Countries
//
//  Created by Syft on 03/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import UIKit
import CoreData


class CountryListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var countryTableView: UITableView!
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.estimatedRowHeight = 100
        countryTableView.dataSource = self
        countryTableView.accessibilityIdentifier = "CountryTable"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUD.show(in: view.window!)
        Server.shared.countryList() { (response, error)  in
            
            if let countries = response as? [Country] {
                self.countries = countries
            }

            HUD.dismiss(from: self.view.window!)
            guard error == nil else {
                assertionFailure("There was an error: \(error!)")
                return
            }
            
            self.countryTableView.reloadData()
        }
    }
    
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryInfoCell") as? CountryTableViewCell {
            
            if let country = countries?[indexPath.row] {
                cell.country.text = country.name
                cell.capital.text = country.capital
                if country.capital == "" {
                    cell.capitalLabel.isHidden = true
                } else {
                    cell.capitalLabel.isHidden = false
                }
                
                cell.population.text = String(country.population.formatLargeNumbers())

                cell.accessibilityIdentifier = "\(country.name!)-Cell"
                cell.country.accessibilityIdentifier = "Country"
                cell.capital.accessibilityIdentifier = "\(country.name!)-Capital"
                cell.capitalLabel.accessibilityIdentifier = "\(country.name!)-Capital-Label"
                cell.population.accessibilityIdentifier = "\(country.name!)-Population"
                cell.populationLabel.accessibilityIdentifier = "\(country.name!)-Population-Label"
                
            }
            
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
}

