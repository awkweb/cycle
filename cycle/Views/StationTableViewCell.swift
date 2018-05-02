import UIKit

class StationTableViewCell: UITableViewCell {
    
    static let Identifier = "StationTableViewCell"

    let nameLabel = UILabel()
    let pointsLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.nameLabel.frame = CGRect(
            x: 10,
            y: 10,
            width: 200,
            height: 50
        )
        
        self.pointsLabel.frame = CGRect(
            x: 210,
            y: 10,
            width: 200,
            height: 50
        )
        
        contentView.addSubview(self.nameLabel)
        contentView.addSubview(self.pointsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWithStation(_ station: Station) {
        self.nameLabel.text = station.properties.name
        let pluralization = station.properties.bikeAngelsPoints > 1 ? "s" : ""
        self.pointsLabel.text = "\(station.properties.bikeAngelsPoints) point\(pluralization)"
    }

}
