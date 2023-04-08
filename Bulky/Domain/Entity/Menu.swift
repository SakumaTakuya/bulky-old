//
//  Menu.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

struct Menu : Codable, Equatable {
    let name : String
    let alts : [String]
    
    init(name: String, alts: [String] = []) {
        self.name = name
        self.alts = alts
    }
}
