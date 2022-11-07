//
//  BusinessSubscriptionService.swift
//  Collie
//
//  Created by Pablo Penas on 20/10/22.
//

import Foundation
import Combine
import Alamofire

final class BusinessSubscriptionService {
//    private let domainUrl = "https://backend-python-dev.vercel.app/"
    private let domainUrl = "http://127.0.0.1:8000/"
    
    func createBusiness(user: UserModel, businessName: String, authenticationToken: String, _ completion: @escaping (Business, BusinessUser) -> ()) {
        let url = domainUrl + "business/create/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        let requestParameters = [ businessName : user ] as [String : UserModel]
        
        AF.request(
            url,
            method: .post,
            parameters: requestParameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 5
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Business created")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                print(response.data!.description)
                let decodedData = try JSONDecoder().decode(User_BusinessDTO.self, from: response.data!)
                completion(decodedData.business, decodedData.businessUser)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func fetchBusiness(user: UserModel, authenticationToken: String, _ completion: @escaping ([Business], [BusinessUser]) -> ()) {
        let url = domainUrl + "business/fetch/" + "?user_id=\(user.id)"
        
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
                print("Business fetching Successful")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(BusinessDTO.self, from: response.data!)
                completion(decodedData.business, decodedData.businessUsers)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func loginBusiness(authenticationToken: String, code: String, user: UserModel, _ completion: @escaping ([Business], [BusinessUser]) -> ()) {
        let url = domainUrl + "business/login/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        let requestParameters = [ code : user ] as [String : UserModel]
        
        AF.request(
            url,
            method: .post,
            parameters: requestParameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 5
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Business login Successful")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(BusinessDTO.self, from: response.data!)
                completion(decodedData.business, decodedData.businessUsers)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func refreshBusiness(authenticationToken: String, businessId: String, _ completion: @escaping (Business) -> Void) {
        let url = domainUrl + "business/refresh/" + "?businessId=\(businessId)"
        
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
                print("Business refreshing Successful")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(Business.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func updateBusiness(authenticationToken: String, business: Business, _ completion: @escaping (Business) -> Void) {
        let url = domainUrl + "business/update/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: business,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 5
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Business update Successful")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(Business.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
}

