//
//  Breeds.swift
//  CatApp
//
//  Created by Алексей Павлюк on 23.04.2020.
//  Copyright © 2020 CocoaOneLove. All rights reserved.
//

import Foundation

struct Breeds: Codable {
    
    let id: String?
    let name: String?
    let description: String?
    let weight: Weight
    let temperament: String?
    let origin: String?
    let life_span: String?
    
    enum CodingKeys: String, CodingKey {
        case weight, id, name
        case description
        case temperament
        case origin
        case life_span
    }
    
}

struct Weight: Codable {
    let metric: String?
}

struct BreedImage: Codable {
    
    let url: String?
    
}


