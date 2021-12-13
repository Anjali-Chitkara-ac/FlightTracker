//
//  ViewController.swift
//  FlightTracker
//
//  Created by Anjali Chitkara on 11/12/21.
//

import UIKit
import SwiftyJSON
import SwiftSpinner
import Alamofire
import PromiseKit

class ViewController: UIViewController{
    
    @IBOutlet weak var fromTxtField: UITextField!
    
    @IBOutlet weak var toTxtField: UITextField!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    var flightNums = [String]()
    var flights = [Flight]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let flightsURL = "http://api.aviationstack.com/v1/flights?access_key="
    
    let accessID = "2bb06e9e21ff5d440b73f5fa5a2319ca"
    
    func getFlightNums() -> Promise<[Flight]>{
                
        return Promise<[Flight]>{ seal -> Void in
            
            var departure = fromTxtField.text
            var arrival = toTxtField.text
            print("\(departure) \(arrival)")
            
            let url = flightsURL + accessID
            
            SwiftSpinner.show("Searching for flights")
            
            AF.request(url).responseJSON {response in
                
                SwiftSpinner.hide()

                if (response.error != nil){//there was error
                    print("error : \(response.error)")
                    seal.reject(response.error!)
                }

                print(url)
                //valid response
                let allFlightData = JSON(response.data!)
                let allFlights = allFlightData["data"]
                
                var someArr = [String]()
                var someFlights = [Flight]()
                
                for flight in allFlights{
                    var f = flight.1
                    var dep = f["departure"]["iata"]
                    var arr = f["arrival"]["iata"]
                    
                    print("\(dep) \(arr)")
                    if(departure == dep.stringValue && arrival == arr.stringValue){
                        print(f)
                        
                        //add flight to an arr
                        var flightNum = f["flight"]["iata"]
    
                        someArr.append(flightNum.rawValue as! String)
                        
                        //delays
                        var depDelay = f["departure"]["delay"].stringValue
                        var arrDelay = f["departure"]["delay"].stringValue
                                                
                        //create flight object
                        let fl = Flight()
                        fl.flightNumber = flightNum.stringValue
                        fl.arrival = arr.stringValue
                        fl.departure = dep.stringValue
                        fl.status = f["flight_status"].stringValue
                        fl.airlines = f["airline"]["name"].stringValue
                        fl.scheduledArrivalTime = f["arrival"]["scheduled"].stringValue
                        fl.estimatedArrivalTime = f["arrival"]["estimated"].stringValue
                        fl.scheduledDepartureTime = f["departure"]["scheduled"].stringValue
                        fl.estimatedDepartureTime = f["departure"]["estimated"].stringValue
                        fl.depDelay = depDelay
                        fl.arrDelay = arrDelay
                        
                        someFlights.append(fl)
                    }
                    
                }//end of for loop HGH TSN CPT PLZ
                
                if(someFlights.count == 0){
                    print("No flights scheduled for this route")
                    self.statusLbl.text = "No flights scheduled for this route"
                    //seal.reject("No flights scheduled for this route" as! Error)
                }
                else{
                    self.statusLbl.text = ""
                    print(someFlights)
                    seal.fulfill(someFlights)
                }
            }//end of AF responsE
        }
    }
    

    @IBAction func a_searchF(_ sender: Any) {
        //getFlightNums()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        getFlightNums().done { flight in
           self.flights.append(contentsOf: flight)
        }
        .catch { error in
           print(error)
        }
        
        guard let searchVC = segue.destination as? SearchResultsViewController else {return}
        searchVC.flightNumbers = self.flightNums
        searchVC.matchingFlights = self.flights
        
        print(searchVC.flightNumbers)
        self.flightNums.removeAll()
        self.flights.removeAll()
    }


}

