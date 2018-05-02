import UIKit
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

class AppViewController: UIViewController {
    
    var provider: Networking!
    private let disposeBag = DisposeBag()
    private let horizontalPadding: CGFloat = 10.0
    private let verticalPadding: CGFloat = 75.0
    private var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    private var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    
    // MARK: - UI Variables
    
    let segmentControl = UISegmentedControl()
    let tableView = UITableView()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpSegmentControl()
        setUpCellConfiguration(action: "take")
    }
    
    // MARK: - Methods
    
    private func setUpSegmentControl() {
        self.segmentControl.frame = CGRect(
            x: self.horizontalPadding,
            y: 40.0,
            width: self.screenWidth - (self.horizontalPadding * 2),
            height: 35.0
        )
        self.segmentControl.backgroundColor = UIColor(red:0.96, green:0.95, blue:0.96, alpha:1.00)
        self.segmentControl.insertSegment(withTitle: "Pick Up", at: 0, animated: true)
        self.segmentControl.insertSegment(withTitle: "Drop Off", at: 1, animated: true)
        self.segmentControl.selectedSegmentIndex = 0
        self.view.addSubview(self.segmentControl)
        
        self.segmentControl.rx.value.asObservable()
            .subscribe { value in
                self.setUpCellConfiguration(action: value.element! == 0 ? "take" : "give")
            }
    }
    
    private func setUpTableView() {
        self.tableView.frame = CGRect(
            x: 0,
            y: self.verticalPadding,
            width: self.screenWidth,
            height: self.screenHeight
        )
        self.tableView.register(StationTableViewCell.self, forCellReuseIdentifier: StationTableViewCell.Identifier)
        self.view.addSubview(self.tableView)
    }

    private func setUpCellConfiguration(action: String) {
        let region = self.provider
            .request(.stations)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapTo(object: Region.self)
            .retry(2)
            .throttle(1, scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
        
        region
            .map { region in
                region.stations.filter { station in
                    station.properties.bikeAngelsAction == action
                }
            }
            .bind(to: self.tableView.rx.items(cellIdentifier: StationTableViewCell.Identifier, cellType: StationTableViewCell.self)) { (index, station, cell) in
                cell.configureWithStation(station)
            }
            .disposed(by: disposeBag)
    }
    
}
