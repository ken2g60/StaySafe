import UIKit


struct attributes: Codable {
    var last_update: String?
    var recovered: Int?
    var county: String?
    var cases_per_100k: Float?
    var cases: Int?
    var ade: Int?

    private enum CodingKeys: String, CodingKey {
        case last_update = "last_update"
        case recovered = "recovered"
        case county = "county"
        case cases_per_100k = "cases_per_100k"
        case cases = "cases"
        case ade = "ADE"
    }
}

struct features: Codable {
    var attributes: attributes
}

struct fields: Codable {
    
    struct FieldParameter: Codable {
        var name: String
        var type: String
        var sqlType: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "name"
            case type = "type"
            case sqlType = "sqlType"
        }
    }
}


struct spatialReference: Codable {
    var wkid: Double
    var latestWkid: Double
    
    private enum CodingKeys: String, CodingKey {
        case wkid = "wkid"
        case latestWkid = "latestWkid"
    }
}


struct geometryProperties: Codable {
    var shapeAreaFieldName: String
    var shapeLengthFieldName: String
    var units: String
}


struct uniqueIdField: Codable {
    var name: String
    var isSystemMaintained: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case isSystemMaintained = "isSystemMaintained"
    }
}



struct Response: Codable {
    let objectIdFieldName: String
    let globalIdFieldName: String
    let uniqueIdField: uniqueIdField
    
    // let geometryProperties: geometryProperties
    let spatialReference: spatialReference
    let fields: fields
    let features: [features]
    
    
    private enum CodingKeys: String, CodingKey {
        case objectIdFieldName = "objectIdFieldName"
        case uniqueIdField = "uniqueIdField"
        case globalIdFieldName = "globalIdFieldName"
        // case geometryProperties = "geometryProperties"
        case spatialReference = "spatialReference"
        case fields = "fields"
        case features = "features"
    }
    

    
}






let url = URL(string: "https://services7.arcgis.com/mOBPykOjAyBO2ZKk/arcgis/rest/services/RKI_Landkreisdaten/FeatureServer/0/query?where=1%3D1&outFields=last_update,recovered,county,cases_per_100k,cases,ADE&returnGeometry=false&outSR=4326&f=json")

let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in

    if let error = error {
        print(error.localizedDescription)
    }
    
    if let data = data {
        parseJSONData(data: data)
    }
}


func parseJSONData(data: Data) -> [Response] {

    let responseCasesModel = [Response]()
    
    
    do {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let newsUpdateDataStore = try decoder.decode(Response.self, from: data)
        print(newsUpdateDataStore)
        // print(newsUpdateDataStore)

        
    } catch {
        print(error)
    }
    return responseCasesModel

}


task.resume()
