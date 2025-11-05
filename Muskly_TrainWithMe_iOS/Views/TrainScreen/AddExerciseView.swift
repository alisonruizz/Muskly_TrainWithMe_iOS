// Views/AddExerciseView.swift
import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name: String = ""
    @State private var series: String = ""
    @State private var reps: String = ""
    @State private var weight: String = ""

    var onSave: (Exercise) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise Details") {
                    TextField("Exercise name", text: $name)
                    TextField("Series", text: $series)
                        .keyboardType(.numberPad)
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                    TextField("Weight (kg)", text: $weight)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let s = Int(series),
                           let r = Int(reps),
                           let w = Int(weight),
                           !name.isEmpty {
                            onSave(Exercise(name: name, series: s, reps: r, weight: w))
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

