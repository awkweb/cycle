import Foundation
import Moya
import RxMoya
import RxSwift

class Provider<Target> where Target: Moya.TargetType {
    
    fileprivate let provider: MoyaProvider<Target>
    
    init(
        endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
        manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        self.provider = MoyaProvider(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            manager: manager,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }
    
    func request(_ token: Target) -> Observable<Moya.Response> {
        return self.provider.rx.request(token).asObservable()
    }
    
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: Provider<T> { get }
}

struct Networking: NetworkingType {
    typealias T = CitibikeAPI
    let provider: Provider<CitibikeAPI>
}

// "Public" interfaces
extension Networking {
    /// Request to fetch a given target. Ensures that valid XApp tokens exist before making request
    func request(_ token: CitibikeAPI) -> Observable<Moya.Response> {
        return self.provider.request(token)
    }
}

// Static methods
extension NetworkingType {
    
    static func newDefaultNetworking() -> Networking {
        return Networking(provider: newProvider(plugins))
    }
    
    static func newStubbingNetworking() -> Networking {
        let provider: Provider<CitibikeAPI> = Provider(
            endpointClosure: endpointsClosure(),
            requestClosure: Networking.endpointResolver(),
            stubClosure: MoyaProvider.immediatelyStub
        )
        return Networking(provider: provider)
    }
    
    static func endpointsClosure<T>() -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint: Endpoint = Endpoint(
                url: url(target),
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: nil
            )
            return endpoint
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        let stubResponses = false
        return stubResponses ? .immediate : .never
    }
    
    static var plugins: [PluginType] {
        return []
    }
    
    // (Endpoint, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch let error {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType]) -> Provider<T> where T: TargetType {
    return Provider(
        endpointClosure: Networking.endpointsClosure(),
        requestClosure: Networking.endpointResolver(),
        stubClosure: Networking.APIKeysBasedStubBehaviour,
        plugins: plugins
    )
}
