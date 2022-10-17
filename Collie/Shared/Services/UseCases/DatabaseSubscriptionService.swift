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
    private let domainUrl = "https://backend-python-dev.vercel.app/"
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
//            "Accept": "application/json"
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
            completion([dataToWrite])
        }
        
        
        
//        var request = URLRequest(url: URL!)
//        request.httpMethod = "POST"
//        request.setValue("application/png", forHTTPHeaderField: "Content-Type")
//
//        let task = URLSession.shared.dataTask(with: URL!, completionHandler: { (data, response, error) in
//            if let error = error {
//                print("Error with creating journey: \(error)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                //                httpResponse.value(forHTTPHeaderField: "authenticationBearer")
//                print("Error with the response, unexpected status code: \(String(describing: response))")
//                return
//            }
//            if let data = data {
//                let response = try? JSONDecoder().decode([ModelDTO].self, from: data)
//                completion(response ?? [])
//            }
//        })
//        task.resume()
    }
    
    func fetchData(_ completion: @escaping ([ModelDTO]) -> ()) {
        let url = domainUrl + route.rawValue + "fetch/"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching journeys: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data {
                let response = try! JSONDecoder().decode([ModelDTO].self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            }
        })
        task.resume()
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
