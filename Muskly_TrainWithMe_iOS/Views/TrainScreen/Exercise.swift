//
//  Exercise.swift
//  Muskly_TrainWithMe_iOS
//
//  Created by Telematica on 1/11/25.
//

import Foundation

struct Exercise: Identifiable, Codable {
    let id = UUID()        
    var name: String
    var series: Int
    var reps: Int
    var weight: Int
}
