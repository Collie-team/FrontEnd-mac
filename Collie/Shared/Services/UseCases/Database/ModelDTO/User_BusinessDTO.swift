//
//  User_Business.swift
//  Collie
//
//  Created by Pablo Penas on 20/10/22.
//

import Foundation

struct User_BusinessDTO: Codable {
    var user: UserModel
    var business: [Business]
}
