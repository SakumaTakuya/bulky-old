//
//  MenuRepository.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation

protocol MenuRepository {
    func get(name : String) async -> Menu?
    func search(name : String) async -> [Menu]
    func store(item : Menu) async -> Menu
}
