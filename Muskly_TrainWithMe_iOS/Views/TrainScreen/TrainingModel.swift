//
//  TrainingModel.swift
//  Muskly_TrainWithMe_iOS
//
//  Created by Telematica on 1/11/25.
//

import Foundation
import SwiftUI

@MainActor
class TrainingViewModel: ObservableObject {
    @Published var routines: [String: [Exercise]] = [:]

    func addExercise(day: String, exercise: Exercise) {
        var updated = routines
        var dayList = updated[day] ?? []
        dayList.append(exercise)
        updated[day] = dayList
        routines = updated
    }

    func removeExercise(day: String, index: Int) {
        var updated = routines
        guard var dayList = updated[day], dayList.indices.contains(index) else { return }
        dayList.remove(at: index)
        updated[day] = dayList
        routines = updated
    }
}
