import Foundation
import SwiftyJSON

@objcMembers final class StationGeometry: NSObject, JSONAbleType {
    
    let latitude: Float
    let longitude: Float
    let type: String

    init(latitude: Float, longitude: Float, type: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.type = type
    }
    
    static func fromJSON(_ json:[String: Any]) -> StationGeometry {
        let json = JSON(json)
        
        let coordinates = json["coordinates"].arrayValue
        let latitude = coordinates[0].floatValue
        let longitude = coordinates[1].floatValue
        let type = json["type"].stringValue
        
        return StationGeometry(
            latitude: latitude,
            longitude: longitude,
            type: type
        )
    }
    
}
