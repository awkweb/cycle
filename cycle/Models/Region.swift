import Foundation
import SwiftyJSON

@objcMembers final class Region: NSObject, JSONAbleType {
    
    let stations: [Station]
    let type: String

    init(stations: [Station], type: String) {
        self.stations = stations
        self.type = type
    }
    
    static func fromJSON(_ json: [String: Any]) -> Region {
        let json = JSON(json)
        
        let stations = json["features"].arrayValue.map { Station.fromJSON($0.dictionaryObject!) }
        let type = json["type"].stringValue
        
        return Region(stations: stations, type: type)
    }
    
}

