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
//    private let domainUrl = "http://127.0.0.1:8000/"
    
    enum DatabaseSubscriptionRoutes: String {
        case journey = "journey/"
        case user = "user/"
        case business = "business/"
    }
    
    init(route: DatabaseSubscriptionRoutes) {
        self.route = route
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
    
    func fetchDataFromUser(user: UserModel, authenticationToken: String, _ completion: @escaping ([ModelDTO]) -> ()) {
        let url = domainUrl + route.rawValue + "fetch/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .put,
            parameters: user,
            encoder: JSONParameterEncoder.default,
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
