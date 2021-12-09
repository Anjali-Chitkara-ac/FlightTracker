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
    
    
    var flightNums = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //let airportURL = "http://api.aviationstack.com/v1/airports?access_key="
    let flightsURL = "http://api.aviationstack.com/v1/flights?access_key="
    
    let accessID = "599b97558da1bbfcb0d541104eb67434"
    
    func getFlightNums() -> Promise<[String]>{
                
        return Promise<[String]>{ seal -> Void in
            
            var departure = fromTxtField.text
            var arrival = toTxtField.text
            print("\(departure) \(arrival)")
            
            let url = flightsURL + accessID
            
            AF.request(url).responseJSON {response in

                if (response.error != nil){//there was error
                    print("error : \(response.error)")
                    seal.reject(response.error!)
                }

                print(url)
                //valid response
                let allFlightData = JSON(response.data!)
                let allFlights = allFlightData["data"]
                
                var someArr = [String]()
                
                for flight in allFlights{
                    var f = flight.1
                    var dep = f["arrival"]["iata"]
                    var arr = f["departure"]["iata"]
                    
                    print("\(dep) \(arr)")
                    if(departure == dep.stringValue && arrival == arr.stringValue){
                        print(f)
                        //add flight to an arr
                        var flightNum = f["flight"]["iata"]
                        print(flightNum)
                        someArr.append(flightNum.rawValue as! String)
                        
                    }
                    
                }//end of for loop HGH TSN CPT PLZ
                
                print(someArr)
                seal.fulfill(someArr)
                
            }//end of AF responsE
        }
    }
    

    @IBAction func a_searchF(_ sender: Any) {
        //getFlightNums()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        getFlightNums().done { flight in
           self.flightNums.append(contentsOf: flight)
        }
        .catch { error in
           print(error)
        }
        
        guard let searchVC = segue.destination as? SearchResultsViewController else {return}
        searchVC.flightNumbers = self.flightNums
        
        print(searchVC.flightNumbers)
        self.flightNums.removeAll()
    }

}

