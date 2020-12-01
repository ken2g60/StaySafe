import UIKit
import SwiftyJSON


struct casesUpdate {
    var cases: Int?
    var last_update: String = ""
    var county: String = ""
        
    init(cases: Int, last_update: String, county: String) {
        self.cases = cases
        self.last_update = last_update
        self.county = county
    }
}

let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=cases,deaths,last_update,recovered,county,cases_per_100k&outSR=4326&f=json")

let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in

    if let error = error {
        print(error.localizedDescription)
    }
    
    if let data = data {
        let json = try! JSON(data: data)
        for (_, data) in json["features"] {
            let attr = data["attributes"]
            
            let cases = attr["cases"].int
            let last_update = attr["last_update"].string
            let county = attr["county"].string
            print(casesUpdate(cases: cases!, last_update: last_update!, county: county!))
        }
        
    }
}

task.resume()
