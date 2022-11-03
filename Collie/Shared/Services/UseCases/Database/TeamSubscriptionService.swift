//
//  TeamSubscriptionService.swift
//  Collie
//
//  Created by Pablo Penas on 01/11/22.
//

import Foundation
import Alamofire

final class TeamSubscriptionService {
//    private let domainUrl = "https://backend-python-dev.vercel.app/"
    private let domainUrl = "http://127.0.0.1:8000/"
    
    func fetchTeamInfo(business: Business, authenticationToken: String, _ completion: @escaping ([BusinessUser],[UserModel]) -> ()) {
        let url = domainUrl + "team/fetch/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: business,
            encoder: .urlEncodedForm,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
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
                let decodedData = try JSONDecoder().decode(TeamListDTO.self, from: response.data!)
                print(decodedData)
                completion(decodedData.businessUser, decodedData.users)
            } catch {
                //handle error
                print(error)
            }
        }
    }
}
