//
//  DetailsViewController.swift
//  FlightTracker
//
//  Created by Anjali Chitkara on 12/9/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var routeLbl: UILabel!
    @IBOutlet weak var flightNumLbl: UILabel!
    @IBOutlet weak var airlinesLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var scheduledArr: UILabel!
    
    @IBOutlet weak var estimatedArr: UILabel!
    
    @IBOutlet weak var scheduledDep: UILabel!
    
    @IBOutlet weak var delayLbl: UILabel!
    @IBOutlet weak var estimatedDep: UILabel!
    var flightDetail : Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routeLbl.text = "\(flightDetail!.departure) -> \(flightDetail!.arrival)"
        flightNumLbl.text = flightDetail!.flightNumber
        statusLbl.text = "Status : \(flightDetail!.status)"
        airlinesLbl.text = flightDetail!.airlines
        scheduledArr.text = flightDetail!.scheduledArrivalTime
        estimatedArr.text = flightDetail!.estimatedArrivalTime
        scheduledDep.text = flightDetail!.scheduledDepartureTime
        estimatedDep.text = flightDetail!.estimatedDepartureTime

        var arrDelay = flightDetail!.arrDelay
        var depDelay = flightDetail!.depDelay
        
        if(arrDelay=="" && depDelay==""){
            delayLbl.text = "ON TIME"
            delayLbl.backgroundColor = UIColor.green
        }
        else{
            //print("\(arrDelay) \(depDelay)")
            delayLbl.text = "DELAYED"
            delayLbl.backgroundColor = UIColor.red
        }
    }
    

}
