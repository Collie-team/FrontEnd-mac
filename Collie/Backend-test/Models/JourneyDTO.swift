//
//  JourneyDTO.swift
//  Collie
//
//  Created by Pablo Penas on 20/09/22.
//

import Foundation

struct JourneyDTO: Codable {
    var journeys: [JourneyModel] = Array()
    
    enum CodingKeys: String, CodingKey {
        case journeys = "Journeys"
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeysDTO.self)
//        print(values)
//        journeys = try values.decode([JourneyModel].self, forKey: .journeys)
//    }
}
