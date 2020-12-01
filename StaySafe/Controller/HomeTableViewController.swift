//
//  HomeTableViewController.swift
//  StaySafe
//
//  Created by knight on 11/28/20.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import UserNotifications

class HomeTableViewController: UITableViewController {
    
    var responseData = [ResponseData]()
    var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coronaApiEndpoint()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return responseData.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
    
    func coronaApiEndpoint(){
        let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=last_update,recovered,county,cases_per_100k,cases,ADE&returnGeometry=false&outSR=4326&f=json")
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let error = error {
                print()
                self.handleError(title: "Error", message: "Something Went Wrong \(error.localizedDescription)")
            }
            
            if let data = data {
                self.responseData = self.parseJSONData(data: data)
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.hideIndicator()
                }
               
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
            }
        } catch {
            let appAlert = UIAlertController(title: "Error", message: "Something Went Wrong", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            appAlert.addAction(okButton)
            self.present(appAlert, animated: true, completion: nil)
        }
        return responseCasesModel
    }
    

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUpdates", for: indexPath) as! HomeTableCell
            
        cell.cases.text = "\(String(describing: responseData[indexPath.row].cases))"
        cell.county.text = responseData[indexPath.row].county
        cell.last_update.text = responseData[indexPath.row].last_update
        cell.statusImage.image = UIImage(named: "alert")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CaseDetailViewController
                destinationController.cases = String(responseData[indexPath.row].cases!)
                destinationController.location = responseData[indexPath.row].county
                destinationController.last_update = responseData[indexPath.row].last_update
            }
        }
    }
    
    func hideIndicator()  {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func prepareNotification() {
        if responseData.count <= 0 {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = ""
        content.subtitle = ""
        content.body = ""
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "staysafe", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func handleError(title: String, message: String) {
        let app = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        app.addAction(okButton)
        self.present(app, animated: true, completion: nil)
    }


}
