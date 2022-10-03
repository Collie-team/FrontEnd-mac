//
//  APIService.swift
//  Collie
//
//  Created by Pablo Penas on 29/09/22.
//

import Foundation

final class APISubscriptionService {
    private let domainUrl = "https://backend-python-dev.vercel.app/"
    private let route: APISubscriptionRoutes
    
    enum APISubscriptionRoutes: String {
        case email = "email/"
        case authentication = "auth/"
    }
    
    init(route: APISubscriptionRoutes) {
        self.route = route
    }
    
    func sendEmail(
        message: String = "Esse é um e-mail teste da Collie, se você está vendo esse e-mail, significa que deu boa demais!"
    ) {
        let url = domainUrl + route.rawValue + "q?message=" + message
        let myURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let URL = URL(string: myURL!)
        
        let task = URLSession.shared.dataTask(with: URL!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with sending email: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
//            if let data = data {
//                let response = try? JSONDecoder().decode([ModelDTO].self, from: data)
//                completion(response ?? [])
//            }
        })
        task.resume()
    }
}
