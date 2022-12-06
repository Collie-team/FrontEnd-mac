
import Foundation
import Alamofire

final class UserTaskSubscriptionService {
    private let domainUrl = "https://backend-python-dev.vercel.app/"
    
    func createUserTasks() {
//        let url = domainUrl + "userTask/update/"
//        
//        let headers: HTTPHeaders = [
//            "Authorization": authenticationToken,
//            "Accept": "application/json"
//        ]
//        
//        AF.request(
//            url,
//            method: .put,
//            parameters: businessUser,
//            encoder: JSONParameterEncoder.default,
//            headers: headers
//        ) { urlRequest in
//            urlRequest.timeoutInterval = 10
//        }.response { response in
//            print(response.debugDescription)
//            switch response.result {
//            case .success:
//                print("Business user updated")
//            case let .failure(error):
//                print(error)
//            }
//            // TODO: Synchronize data from response
//            do {
//                let decodedData = try JSONDecoder().decode(BusinessUser.self, from: response.data!)
//                completion(decodedData)
//            } catch {
//                //handle error
//                print(error)
//            }
//        }
    }
}
