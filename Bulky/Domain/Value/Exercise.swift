//
//  WorkoutSet.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

struct Exercise : Codable, Equatable, Hashable {
    let weight : Float
    let rest : Float
    let reps : Int
}
