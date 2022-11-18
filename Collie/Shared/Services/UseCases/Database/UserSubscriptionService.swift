//
//  UserSubscriptionService.swift
//  Collie
//
//  Created by Pablo Penas on 20/10/22.
//

import Foundation
import Combine
import Alamofire

final class UserSubscriptionService {
    private let domainUrl = "https://backend-python-dev.vercel.app/"
//    private let domainUrl = "http://127.0.0.1:8000/"
    
    func createUser(user: UserModel, authenticationToken: String, _ completion: @escaping (UserModel) -> ()) {
        let url = domainUrl + "user/create/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: user,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("User created")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(UserModel.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func fetchUser(authenticationToken: String, _ completion: @escaping (UserModel) -> ()) {
        let url = domainUrl + "user/fetch/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .get,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            switch response.result {
            case .success:
                print("User fetched")
            case let .failure(error):
                print("ERROR:")
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(UserModel.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func updateUser(authenticationToken: String, userData: UserModel, _ completion: @escaping (UserModel) -> ()) {
        let url = domainUrl + "user/update/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .put,
            parameters: userData,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            switch response.result {
            case .success:
                print("User updated")
            case let .failure(error):
                print("ERROR:")
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(UserModel.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func eraseUserData(userId: String, authenticationToken: String, _ completion: @escaping () -> ()) {
        let url = domainUrl + "user/delete/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .put,
            parameters: userId,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            switch response.result {
            case .success:
                print("User deleted")
            case let .failure(error):
                print("ERROR:")
                print(error)
            }
            completion()
        }
    }
}
