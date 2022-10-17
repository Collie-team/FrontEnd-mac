//
//  DatabaseSubscriptionService.swift
//  Collie
//
//  Created by Pablo Penas on 22/09/22.
//

import Foundation
import Combine
import Alamofire

final class DatabaseSubscriptionService<ModelDTO: Codable> {
    private let route: DatabaseSubscriptionRoutes
//    private let domainUrl = "https://backend-python-dev.vercel.app/"
    private let domainUrl = "http://127.0.0.1:8000/"
    private let _publisher = PassthroughSubject<ModelDTO, Never>()
    
    enum DatabaseSubscriptionRoutes: String {
        case journey = "journey/"
        case user = "user/"
    }
    
    
    init(route: DatabaseSubscriptionRoutes) {
        self.route = route
    }
    
    func publisher() -> PassthroughSubject<ModelDTO, Never> {
        
        return self._publisher
    }
    
    func writeData(dataToWrite: ModelDTO, authenticationToken: String, _ completion: @escaping ([ModelDTO]) -> ()) {
        let url = domainUrl + route.rawValue + "create/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: dataToWrite,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 5
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Validation Successful")
                print("Request ")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodeData = try JSONDecoder().decode(ModelDTO.self, from: response.data!)
                print(decodeData)
                completion([decodeData])
            } catch {
                //handle error
                print(error)
            }
            
            completion([dataToWrite])
        }
    }
    
    func fetchData(authenticationToken: String, _ completion: @escaping ([ModelDTO]) -> ()) {
        let url = domainUrl + route.rawValue + "fetch/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 5
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Request Successful")
                print("Request ")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodeData = try JSONDecoder().decode(ModelDTO.self, from: response.data!)
                print(decodeData)
                completion([decodeData])
            } catch {
                //handle error
                print(error)
            }
        }
    }
}

extension Publisher where Failure == Never {
    func aggregated() -> Publishers.Aggregate<Self> {
        .init(upstream: self)
    }
}

extension Publishers {
    final class Aggregate<P>: Publisher where P: Publisher, P.Failure == Never {
        typealias Output = [P.Output]
        typealias Failure = Never
        
        let upstream: P
        private var currentItems: Output = []
        
        private var cancelBag: [AnyCancellable] = []
        
        init(upstream: P) {
            self.upstream = upstream
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, [P.Output] == S.Input {
            upstream.sink { newValue in
                self.currentItems.append(newValue)
                subscriber.receive(self.currentItems)
            }
            .store(in: &cancelBag)
        }
    }
}
