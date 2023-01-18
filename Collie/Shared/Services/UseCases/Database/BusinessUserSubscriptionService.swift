import Foundation
import Alamofire

final class BusinessUserSubscriptionService {
    private let domainUrl = "https://backend-python-dev.vercel.app/"
//    private let domainUrl = "http://127.0.0.1:8000/"
    
    func updateBusinessUser(businessUser: BusinessUser, authenticationToken: String, _ completion: @escaping (BusinessUser) -> ()) {
        let url = domainUrl + "businessUser/update/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        AF.request(
            url,
            method: .put,
            parameters: businessUser,
            encoder: JSONParameterEncoder.default,
            headers: headers
        ) { urlRequest in
            urlRequest.timeoutInterval = 10
        }.response { response in
            print(response.debugDescription)
            switch response.result {
            case .success:
                print("Business user updated")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(BusinessUser.self, from: response.data!)
                completion(decodedData)
            } catch {
                //handle error
                print(error)
            }
        }
    }
    
    func fetchBusinessUser(userId: String, businessId: String, authenticationToken: String, _ completion: @escaping (BusinessUser, UserModel) -> ()) {
        let url = domainUrl + "businessUser/fetch/"
        
        let headers: HTTPHeaders = [
            "Authorization": authenticationToken,
            "Accept": "application/json"
        ]
        
        let parameters: [String : String] = ["userId" : userId, "businessId" : businessId]
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
                print("Business user fetched")
            case let .failure(error):
                print(error)
            }
            // TODO: Synchronize data from response
            do {
                let decodedData = try JSONDecoder().decode(User_BusinessUserDTO.self, from: response.data!)
                completion(decodedData.businessUser, decodedData.user)
            } catch {
                //handle error
                print(error)
            }
        }
    }
}
