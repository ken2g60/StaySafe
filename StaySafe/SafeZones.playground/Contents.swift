import UIKit

struct CasesUpdate: Codable {
    var cases: Int?
    var last_update: String = ""
    var county: String = ""
        
    init(cases: Int, last_update: String, county: String) {
        self.cases = cases
        self.last_update = last_update
        self.county = county
    }
}



enum Endpoint {
    case green
    case yellow
    case red
    case dark_red
}


extension Endpoint {
    var url: URL {
        switch self {
        case .green:
            return .greenEndpoint("green")

        case .yellow:
            return .yellowEndpoint("green")
            
        case .red:
            return .redEndpoint("green")
            
        case .dark_red:
            return .darkRedEndpoint("green")
        }
    }
}

private extension URL {
    static func greenEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=last_update,recovered,county,cases_per_100k,cases,ADE&returnGeometry=false&outSR=4326&f=json")!
    }
    
    static func yellowEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=last_update,recovered,county,cases_per_100k,cases,ADE&returnGeometry=false&outSR=4326&f=json")!
    }
    
    static func redEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=last_update,recovered,county,cases_per_100k,cases,ADE&returnGeometry=false&outSR=4326&f=json")!
    }
    
    static func darkRedEndpoint(_ endpoint: String) -> URL {
        URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=last_update,recovered,county,cases_per_100k,cases,ADE&returnGeometry=false&outSR=4326&f=json")!
    }
}


// search input value safezones
func getTraffic(traffic: String){
    
    switch traffic {
    case "green":
        return getGreenStatus()
    case "yellow":
        return getYellowStatus()
    case "red":
        return getRedStatus()
    case "dark_red":
        return getDarkRedStatus()
    default:
        print("")
    }
}


func getGreenStatus(){
    
    let endpoint = Endpoint.green
    let tasks = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
        if let error = error {
            print(error)
        }
        
        if let data = data {
            print(data)
        }
    }
    tasks.resume()
}

func getYellowStatus(){
    let endpoint = Endpoint.yellow
    let tasks = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
        if let error = error {
            print(error)
        }
        
        if let data = data {
            print(data)
        }
    }
    tasks.resume()
}


func getRedStatus(){
    let endpoint = Endpoint.red
    let tasks = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
        if let error = error {
            print(error)
        }
        
        if let data = data {
           print(data)
        }
    }
    tasks.resume()
}

func getDarkRedStatus(){
    let endpoint = Endpoint.dark_red
    let tasks = URLSession.shared.dataTask(with: endpoint.url) { (data, response, error) in
        if let error = error {
            print(error)
        }
        
        if let data = data {
            print(data)
        }
    }
    tasks.resume()
}


getTraffic(traffic: "red")
