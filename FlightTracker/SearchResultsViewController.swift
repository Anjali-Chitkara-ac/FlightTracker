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
    
//    let flightNumbers : [String]
//
//    init(flightNumbers : [String]){
//        self.flightNumbers = flightNumbers
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        print("IN 1")
        super.viewDidLoad()
        print("IN 2")
        tblView?.delegate = self
        tblView?.dataSource = self
        
        print("2")
        print(flightNumbers)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = flightNumbers[indexPath.row]
        return cell
    }

}
