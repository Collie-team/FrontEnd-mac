//
//  APIService.swift
//  Collie
//
//  Created by Pablo Penas on 29/09/22.
//

import Foundation
import Alamofire

final class APISubscriptionService {
    private let domainUrl = "https://backend-python-dev.vercel.app/"
//    private let domainUrl = "http://127.0.0.1:8000/"
    
    func redefineBusinessCode(authenticationToken: String, businessId: String, _ completion: @escaping (BusinessKey) -> Void) {
        let url = domainUrl + "code/redefine/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: businessId,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Code redefined")
            case let .failure(error):
                print(error)
            }
            do {
                let decodedData = try JSONDecoder().decode(BusinessKey.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func fetchBusinessCode(authenticationToken: String, businessId: String, _ completion: @escaping (BusinessKey) -> Void) {
        let url = domainUrl + "code/fetch/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: businessId,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Code redefined")
            case let .failure(error):
                print(error)
            }
            do {
                let decodedData = try JSONDecoder().decode(BusinessKey.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func sendInviteEmail(authenticationToken: String, business: Business, email: String, _ completion: @escaping () -> Void) {
        let url = domainUrl + "email/invite/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        let parameters = [ email : business ]
        print(parameters)
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                completion()
                print("Invite email sent")
            case let .failure(error):
                print(error)
            }
        }
    }
}
