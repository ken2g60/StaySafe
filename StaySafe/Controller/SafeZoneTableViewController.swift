//
//  SafeZoneTableViewController.swift
//  StaySafe
//
//  Created by knight on 11/28/20.
//

import UIKit
import MBProgressHUD

class SafeZoneTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
  
    
    @IBOutlet var emptySafeZoneView: UIView!
    var responseData = [SafeZone]()
     var searchController: UISearchController!
    

    var searchData: [String]!
    var safeZoneStatus: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        tableView.backgroundView = emptySafeZoneView
        tableView.backgroundView?.isHidden = true

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if responseData.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return responseData.count
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
   
        switch text.lowercased() {
        
        case "green":
            self.safe_zone(zone: "green")
            
        case "yellow":
            self.safe_zone(zone: "yellow")
            
        case "red":
            self.safe_zone(zone: "red")
            
        case "dark-red":
            self.safe_zone(zone: "dark-red")
            
        default:
            return
        }
        
        if text.isEmpty {
            self.handleError(title: "Error", message: "No Safe Zone e.g green, yellow, red, dark_red")
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("DidChangeText \(searchText)")
    }
      

    func safe_zone(zone: String) {
       
        switch zone {
        case "green":
            return checkSafeZone(zone: zone)
        case "red":
            return checkSafeZone(zone: zone)
        case "yellow":
            return checkSafeZone(zone: zone)
        case "dark-red":
            return checkSafeZone(zone: zone)
        default:
            print("Zone Not Found")
        }
    }
    
    func checkSafeZone(zone:String){
        
        switch zone {
        case "green":
            safeZoneStatus = "green"
            return self.makeAPIRequest(zone: "green", incidence: 35)
        case "yellow":
            safeZoneStatus = "yellow"
            return self.makeAPIRequest(zone: "yellow", incidence: Int.random(in: 35...50))
        case "red":
            safeZoneStatus = "red"
            return self.makeAPIRequest(zone: "red", incidence: 50)
        case "dark-red":
            safeZoneStatus = "dark-red"
            return self.makeAPIRequest(zone: "dark-red", incidence: 50)
        default:
            print("Zone Not Found")
        }
    }


    
    
    func makeAPIRequest(zone: String, incidence: Int){
        
        let api = "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=cases>\(incidence)&outFields=cases,deaths,last_update,recovered,county,cases_per_100k&outSR=4326&f=json"
        
        
        let safeURL = api.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task = URLSession.shared.dataTask(with: URL(string: safeURL)!) { (data, response, error) in
            
            if let error = error {
                self.handleError(title: "Error", message: "Check Your Internet Connection \(error.localizedDescription)")
            }
            
            if let data = data {
                self.responseData = self.parseJSONData(data: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            }
        }
        task.resume()
    }

    func parseJSONData(data: Data) -> [SafeZone] {
        var responseCasesModel = [SafeZone]()
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let newsUpdateDataStore = try decoder.decode(Root.self, from: data)

                for updates in newsUpdateDataStore.features {
                    var casesData = SafeZone()
                    
                    let country = String(updates.attributes.county!)
                    casesData.county = String(country.dropFirst(2))
                    
                    casesData.last_update = updates.attributes.last_update
                    casesData.cases = String(updates.attributes.cases!)
                    casesData.county = updates.attributes.county
                    casesData.status = safeZoneStatus
                    responseCasesModel.append(casesData)
                }
            
        } catch {
            print(error)
        }
        return responseCasesModel
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateTableCell", for: indexPath) as! UpdateTableCell
            
        cell.cases.text = "\(String(describing: responseData[indexPath.row].cases))"
        cell.county.text = responseData[indexPath.row].county
        cell.date.text = responseData[indexPath.row].last_update
        cell.phaseImage.image = UIImage(named: "virus")
        cell.status.text = responseData[indexPath.row].status
        return cell
    }
    
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "updateStatus", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateStatus" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! SafeTipsTableViewController
                destinationController.ruleStatus = responseData[indexPath.row].status
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
