import Foundation
import RxSwift
import Moya
import Alamofire

enum CitibikeAPI {
    case stations
}

extension CitibikeAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://layer.bicyclesharing.net/map/v1/nyc")! }
    
    var path: String {
        switch self {
        case .stations:
            return "/stations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        switch self {
        case .stations:
            return stubbedResponse("stations")
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
}

// MARK: - Provider support

func stubbedResponse(_ filename: String) -> Data! {
    let bundle = Bundle.main
    let path = bundle.path(forResource: filename, ofType: "json", inDirectory: "")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
