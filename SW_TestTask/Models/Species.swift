//
//  Species.swift
//  SW_TestTask
//
//  Created by Tatiana Knysh on 10.01.2019.
//  Copyright © 2019 Tatiana Knysh. All rights reserved.
//

import Foundation

struct Species: Codable {
    var name: String
    
    static func empty() -> Species {
        return Species(name: "")
    }
}
