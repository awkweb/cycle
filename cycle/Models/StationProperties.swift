import Foundation
import SwiftyJSON

@objcMembers final class StationProperties: NSObject, JSONAbleType {
    
    let bikeAngelsAction: String
    let bikeAngelsDigits: Int
    let bikeAngelsPoints: Int
    let bikesAvailable: Int
    let bikesDisabled: Int
    let capcity: Int
    let docksAvailable: Int
    let docksDisabled: Int
    let iconDotBikeLayer: String
    let iconDotDockLayer: String
    let iconPinBikeLayer: String
    let iconPinDockLayer: String
    let id: String
    let installed: Bool
    let lastReported: Int
    let name: String
    let renting: Bool
    let returning: Bool
    let terminal: String
    let valetStatus: String
    
    init(
        bikeAngelsAction: String,
        bikeAngelsDigits: Int,
        bikeAngelsPoints: Int,
        bikesAvailable: Int,
        bikesDisabled: Int,
        capcity: Int,
        docksAvailable: Int,
        docksDisabled: Int,
        iconDotBikeLayer: String,
        iconDotDockLayer: String,
        iconPinBikeLayer: String,
        iconPinDockLayer: String,
        id: String,
        installed: Bool,
        lastReported: Int,
        name: String,
        renting: Bool,
        returning: Bool,
        terminal: String,
        valetStatus: String
    ) {
        self.bikeAngelsAction = bikeAngelsAction
        self.bikeAngelsDigits = bikeAngelsDigits
        self.bikeAngelsPoints = bikeAngelsPoints
        self.bikesAvailable = bikesAvailable
        self.bikesDisabled = bikesDisabled
        self.capcity = capcity
        self.docksAvailable = docksAvailable
        self.docksDisabled = docksDisabled
        self.iconDotBikeLayer = iconDotBikeLayer
        self.iconDotDockLayer = iconDotDockLayer
        self.iconPinBikeLayer = iconPinBikeLayer
        self.iconPinDockLayer = iconPinDockLayer
        self.id = id
        self.installed = installed
        self.lastReported = lastReported
        self.name = name
        self.renting = renting
        self.returning = returning
        self.terminal = terminal
        self.valetStatus = valetStatus
    }
    
    static func fromJSON(_ json:[String: Any]) -> StationProperties {
        let json = JSON(json)
        
        let bikeAngelsAction = json["bike_angels_action"].stringValue
        let bikeAngelsDigits = json["bike_angels_digits"].intValue
        let bikeAngelsPoints = json["bike_angels_points"].intValue
        let bikesAvailable = json["bikes_available"].intValue
        let bikesDisabled = json["bikes_disabled"].intValue
        let capcity = json["capcity"].intValue
        let docksAvailable = json["docks_available"].intValue
        let docksDisabled = json["docks_disabled"].intValue
        let iconDotBikeLayer = json["icon_dot_bike_layer"].stringValue
        let iconDotDockLayer = json["icon_dot_dock_layer"].stringValue
        let iconPinBikeLayer = json["icon_pin_bike_layer"].stringValue
        let iconPinDockLayer = json["icon_pin_dock_layer"].stringValue
        let id = json["station_id"].stringValue
        let installed = json["installed"].boolValue
        let lastReported = json["last_reported"].intValue
        let name = json["name"].stringValue
        let renting = json["renting"].boolValue
        let returning = json["returning"].boolValue
        let terminal = json["terminal"].stringValue
        let valetStatus = json["valet_status"].stringValue

        return StationProperties(
            bikeAngelsAction: bikeAngelsAction,
            bikeAngelsDigits: bikeAngelsDigits,
            bikeAngelsPoints: bikeAngelsPoints,
            bikesAvailable: bikesAvailable,
            bikesDisabled: bikesDisabled,
            capcity: capcity,
            docksAvailable: docksAvailable,
            docksDisabled: docksDisabled,
            iconDotBikeLayer: iconDotBikeLayer,
            iconDotDockLayer: iconDotDockLayer,
            iconPinBikeLayer: iconPinBikeLayer,
            iconPinDockLayer: iconPinDockLayer,
            id: id,
            installed: installed,
            lastReported: lastReported,
            name: name,
            renting: renting,
            returning: returning,
            terminal: terminal,
            valetStatus: valetStatus
        )
    }
    
}
