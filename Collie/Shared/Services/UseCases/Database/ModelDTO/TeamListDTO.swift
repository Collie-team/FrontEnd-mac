//
//  TeamListDTO.swift
//  Collie
//
//  Created by Pablo Penas on 03/11/22.
//

import Foundation

struct TeamListDTO: Codable {
    var businessUser: [BusinessUser]
    var users: [UserModel]
}
