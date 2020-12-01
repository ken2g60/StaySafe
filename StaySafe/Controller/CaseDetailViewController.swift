//
//  CaseDetailViewController.swift
//  StaySafe
//
//  Created by knight on 11/29/20.
//

import UIKit
import MapKit

class CaseDetailViewController: UITableViewController, CLLocationManagerDelegate {

    
    var cases: String?
    var location: String?
    var last_update: String?
    var status: String?
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // remove unused cell
        configure(location: location ?? "")
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          switch indexPath.row {
          case 0:
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CasesTableViewCell.self), for: indexPath) as! CasesTableViewCell
                cell.casesLabel.text = cases
                cell.lastUpdate.text = last_update
              return cell
          case 1:
              let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CaseLocationTableViewCell.self), for: indexPath) as! CaseLocationTableViewCell
            cell.county.text = location
            cell.status.text = status
            return cell
          default:
              fatalError("Failed to instatiate the table view cell for detail view controller")
          }
      }
    
    func configure(location: String){
        let geoCoder = CLGeocoder()
      
        geoCoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                
                let app = UIAlertController(title: "Error", message: "Something Went Wrong \(error.localizedDescription)", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                app.addAction(okButton)
                self.present(app, animated: true, completion: nil)
            }
            
            if placemarks != nil {
                
                // placemark
                let placemark = placemarks?[0]
                
                // annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark?.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    
                    // set the zoom level
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
                
            }
        }
    }

}
