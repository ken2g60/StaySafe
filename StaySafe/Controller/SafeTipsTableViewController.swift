//
//  SafeTipsTableViewController.swift
//  StaySafe
//
//  Created by knight on 11/30/20.
//

import UIKit

class SafeTipsTableViewController: UITableViewController {

    var ruleStatus: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "SafeTipsTableViewCell", for: indexPath) as! SafeTipsTableViewCell
        
       
        if ruleStatus == "green" {
            if indexPath.row == 0 {
                cell.safeTipName.text = "Limitations of face-to-face contact in public spaces"
                cell.safeTipImage.image  = UIImage(named: "keep-distance")
            }
            
            if indexPath.row == 1 {
                cell.safeTipName.text = "Private events ( i.e. weddings etc. ) with a maximum of 100 participants in closed spaces"
                cell.safeTipImage.image  = UIImage(named: "reminder")
            }
            
            if indexPath.row == 2 {
                cell.safeTipName.text = "Wearing a mask is mandatory when using public transportation, going shopping, eating and drinking in restaurants, bars."
                cell.safeTipImage.image  = UIImage(named: "medical-mask")
            }
        }
        
        if ruleStatus == "yellow" {
            if indexPath.row == 0 {
                cell.safeTipName.text = "Private parties and contacts: no more than two households or ten people"
                cell.safeTipImage.image  = UIImage(named: "no-group")
            }
            
            if indexPath.row == 1 {
                cell.safeTipName.text = "Wearing a mask is mandatory in heavily frequented spaces."
                cell.safeTipImage.image  = UIImage(named: "medical-mask")
            }
            
            if indexPath.row == 2 {
                cell.safeTipName.text = "Curfew and ban on selling as well as consuming alcohol in public spaces."
                cell.safeTipImage.image  = UIImage(named: "curfew")
            }
        }
        
        
        if ruleStatus == "red" {
            if indexPath.row == 0 {
                cell.safeTipName.text = "Private parties and contacts: no more than 5 households or five people"
                cell.safeTipImage.image  = UIImage(named: "no-group")
            }
            
            if indexPath.row == 1 {
                cell.safeTipName.text = "Wearing a mask is mandatory in heavily frequented spaces."
                cell.safeTipImage.image  = UIImage(named: "medical-mask")
            }
            
            if indexPath.row == 2 {
                cell.safeTipName.text = "Curfew and ban on selling as well as consuming alcohol in public spaces "
                cell.safeTipImage.image  = UIImage(named: "curfew")
            }
        }
        if ruleStatus == "dark-red" {
            
            if indexPath.row == 0 {
                cell.safeTipName.text = "Events ( e.g. club meetings, sporting events, cultural events, etc. ) must not exceed 50 persons"
                cell.safeTipImage.image  = UIImage(named: "reminder")
            }
            
            if indexPath.row == 1 {
                cell.safeTipName.text = "Closing time for food / gastronomy outlets, ban on alcohol sales and alcohol consumption sales in specific public places"
                cell.safeTipImage.image  = UIImage(named: "curfew")
            }
            
            if indexPath.row == 2 {
                cell.safeTipName.text = .none
                cell.safeTipImage.image = .none
            }
        }

        return cell
    }

}
