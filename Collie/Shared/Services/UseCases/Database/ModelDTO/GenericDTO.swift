//
//  GenericDTO.swift
//  Collie
//
//  Created by Pablo Penas on 20/10/22.
//

import Foundation

struct GenericDTO<Model1, Model2> {
    var model1: Model1
    var model2: Model2
    
    enum GenericDTOCodingKeys: String, CodingKey {
        case model1 = "user"
        case model2 = "business"
    }
}
