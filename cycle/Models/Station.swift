import Foundation
import SwiftyJSON

@objcMembers final class Station: NSObject, JSONAbleType {
    
    let geometry: StationGeometry
    let properties: StationProperties
    let type: String

    init(geometry: StationGeometry, properties: StationProperties, type: String) {
        self.geometry = geometry
        self.properties = properties
        self.type = type
    }
    
    static func fromJSON(_ json: [String: Any]) -> Station {
        let json = JSON(json)

        let geometryJson = json["geometry"].dictionaryObject
        let geometry = StationGeometry.fromJSON(geometryJson!)
        let propertiesJson = json["properties"].dictionaryObject
        let properties = StationProperties.fromJSON(propertiesJson!)
        let type = json["type"].stringValue
        
        return Station(geometry: geometry, properties: properties, type: type)
    }
    
}
