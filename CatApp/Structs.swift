//
//  Breeds.swift
//  CatApp
//
//  Created by Алексей Павлюк on 23.04.2020.
//  Copyright © 2020 CocoaOneLove. All rights reserved.
//

import Foundation

struct Breeds: Decodable {
    
    let id: String?
    let name: String?
    let description: String?
    
}

struct BreedImage: Decodable {
    
    let url: String?
    
}
