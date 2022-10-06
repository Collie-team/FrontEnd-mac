//
//  DatabaseSubscriptionService.swift
//  Collie
//
//  Created by Pablo Penas on 22/09/22.
//

import Foundation
import Combine

protocol QueryParameterable {
    func createQueryParameters() -> String
}


final class DatabaseSubscriptionService<ModelDTO: Decodable & QueryParameterable> {
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
    
    func writeData(dataToWrite: ModelDTO, _ completion: @escaping ([ModelDTO]) -> ()) {
        let query = dataToWrite.createQueryParameters()
        let url = domainUrl + route.rawValue + "create/" + query
        let myURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let URL = URL(string: myURL!)
//        let request = URLRequest(url: URL!)
//        request.httpMethod = 
        
        let task = URLSession.shared.dataTask(with: URL!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with creating journey: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
//                httpResponse.value(forHTTPHeaderField: "authenticationBearer")
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            if let data = data {
                let response = try? JSONDecoder().decode([ModelDTO].self, from: data)
                completion(response ?? [])
            }
        })
        task.resume()
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
