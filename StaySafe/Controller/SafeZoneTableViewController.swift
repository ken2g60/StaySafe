//
//  SafeZoneTableViewController.swift
//  StaySafe
//
//  Created by knight on 11/28/20.
//

import UIKit

class SafeZoneTableViewController: UITableViewController, UISearchResultsUpdating {
  
    
 
    var responseData = [ResponseData]()
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // searchBar.delegate = self
        // searchBar.search = self
        // configureSearch(keyword: searchBar.searchTextField.text!)
        
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Safe Zones"
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func configureSearch(keyword: String) {
        print(keyword)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text.lowercased())
        if text.isEmpty {
            self.handleError(title: "Error", message: "No Safe Zone e.g green, yellow, red, dark_red")
        }
        // default value
        // self.safe_zone(zone: text.lowercased(), status: 10)
    }
        

    func safe_zone(zone: String, status: Int) {
       
        switch zone {
        case "green":
            return checkSafeZone(zone: zone, status: status)
        case "red":
            return checkSafeZone(zone: zone, status: status)
        case "yellow":
            return checkSafeZone(zone: zone, status: status)
        case "dark_red":
            return checkSafeZone(zone: zone, status: status)
        default:
            fatalError("Zone Not Found")
        }
    }
    
    func checkSafeZone(zone:String, status: Int){
        
        switch zone {
        case "green":
            return self.makeAPIRequest()
        case "yellow":
            return self.makeAPIRequest()
        case "red":
            return self.makeAPIRequest()
        case "dark_red":
            return self.makeAPIRequest()
        default:
            fatalError("Zone Not Found")
        }
    }


    
    
    func makeAPIRequest(){
        let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where>\(10)outFields=cases,deaths,last_update,recovered,county,cases_per_100k&outSR=4326&f=json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                self.handleError(title: "Error", message: "Check Your Internet Connection \(error.localizedDescription)")
            }
            
            if let data = data {
                self.responseData = self.parseJSONData(data: data)
            }
        }
        task.resume()
    }

    func parseJSONData(data: Data) -> [ResponseData] {
        var responseCasesModel = [ResponseData]()
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let newsUpdateDataStore = try decoder.decode(Root.self, from: data)
            for updates in newsUpdateDataStore.features {
                var casesData = ResponseData()
                casesData.last_update = updates.attributes.last_update
                casesData.recovered = updates.attributes.recovered
                casesData.county = updates.attributes.county
                casesData.cases_per_100k = updates.attributes.cases_per_100k
                casesData.cases = updates.attributes.cases
                casesData.ade = updates.attributes.ade
                responseCasesModel.append(casesData)
                print(responseCasesModel)
            }
            print(newsUpdateDataStore)
            // print(newsUpdateDataStore)
            
        } catch {
            self.handleError(title: "Error", message: "Something Went Wrong!")
        }
        return responseCasesModel
    }
    
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showSafetyTips", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSafetyTips" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CaseDetailViewController
//                destinationController.cases = String(responseData[indexPath.row].cases!)
//                destinationController.location = responseData[indexPath.row].county
//                destinationController.last_update = responseData[indexPath.row].last_update
            }
        }
    }
    
    func handleError(title: String, message: String) {
        let app = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        app.addAction(okButton)
        self.present(app, animated: true, completion: nil)
    }

    
}
