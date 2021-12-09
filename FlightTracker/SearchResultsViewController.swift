//
//  SearchResultsViewController.swift
//  FlightTracker
//
//  Created by Anjali Chitkara on 12/8/21.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    var flightNumbers : [String] = []
    var matchingFlights : [Flight] = []
    
    var flightDetails : Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView?.delegate = self
        tblView?.dataSource = self
        
        //print(flightNumbers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingFlights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = flightNumbers[indexPath.row]
        let flight = matchingFlights[indexPath.row]
        
        cell.textLabel?.text = "\(flight.flightNumber) \(flight.status)"
        return cell
    }
    
    //for details page/segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flightDetails = matchingFlights[indexPath.row]
        performSegue(withIdentifier: "DetailsSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="DetailsSegue"){
            let detalisVC = segue.destination as! DetailsViewController
            detalisVC.flightDetail = self.flightDetails
        }
    }

}
