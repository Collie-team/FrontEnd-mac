//
//  AuthenticationService.swift
//  Collie
//
//  Created by Pablo Penas on 03/10/22.
//

import Foundation

final class AuthenticationService {
//    private let route: AuthenticationSubscriptionRoutes
//    
//    enum AuthenticationSubscriptionRoutes: String {
//        case login = "login/"
//        case signin = "signin/"
//    }
//   
//    init(route: AuthenticationSubscriptionRoutes) {
//        self.route = route
//    }
    private let domainUrl = "https://backend-python-dev.vercel.app/"
    
    func login() {
        let url = domainUrl + "login/"
        let URL = URL(string: url)
        var request = URLRequest(url: URL!)
        request.httpMethod = "POST"
    }
}
