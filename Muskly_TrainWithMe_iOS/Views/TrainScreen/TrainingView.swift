import SwiftUI

struct TrainView: View {
    @StateObject private var viewModel = TrainingViewModel()

    @State private var petName: String = ""
    @State private var selectedDay: String? = nil
    @State private var showForm: Bool = false
    @FocusState private var isTextFieldFocused: Bool

    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Parte superior fija: imagen + título
                VStack(spacing: 12) {
                    Text("Create your new routine")
                        .font(.title3) // Más pequeño para evitar desbordamiento
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                    
                    Image("img25")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                }
                .padding(.top, 16)

                // Tarjeta desplazable
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        // Campo nombre de mascota
                        TextField("Pet name", text: $petName)
                            .padding(12)
                            .background(isTextFieldFocused ? Color("PrimaryContainer") : Color("OutlineVariant"))
                            .cornerRadius(16)
                            .focused($isTextFieldFocused)

                        // Días de la semana tipo FlowRow
                        FlowLayout(alignment: .center, spacing: 8) {
                            ForEach(days, id: \.self) { day in
                                Button {
                                    selectedDay = day
                                } label: {
                                    Text(day)
                                        .font(.subheadline)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(selectedDay == day ? Color("PrimaryContainer") : Color("OutlineVariant"))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                }
                            }
                        }

                        // Lista de ejercicios
                        if let day = selectedDay {
                            let exercises = viewModel.routines[day] ?? []

                            if exercises.isEmpty {
                                Text("No exercises added for \(day)")
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                            } else {
                                VStack(spacing: 8) {
                                    ForEach(Array(exercises.enumerated()), id: \.offset) { index, exercise in
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(exercise.name)
                                                    .font(.headline)
                                                Text("\(exercise.series)x\(exercise.reps) @ \(exercise.weight)kg")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            Spacer()
                                            Button {
                                                viewModel.removeExercise(day: day, index: index)
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        .padding()
                                        .background(Color("OutlineVariant"))
                                        .cornerRadius(12)
                                    }
                                }
                            }

                            // Botón para añadir ejercicio
                            Button {
                                showForm = true
                            } label: {
                                Text("Add exercise")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("PrimaryContainer"))
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                            .padding(.top, 12)
                        }
                    }
                    .padding()
                    .background(Color("Secundary"))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
            }
            .background(Color("SecundaryContainer"))
            .toolbarBackground(Color("Secondary"), for: .navigationBar)
        }
        .sheet(isPresented: $showForm) {
            AddExerciseView { exercise in
                if let day = selectedDay {
                    viewModel.addExercise(day: day, exercise: exercise)
                }
                showForm = false
            }
        }
    }
}

// MARK: - FlowLayout (para simular FlowRow de Android)
struct FlowLayout<Content: View>: View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat
    let content: Content

    init(alignment: HorizontalAlignment = .center, spacing: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60), spacing: spacing)], spacing: spacing) {
            content
        }
    }
}

// MARK: - Preview
#Preview {
    TrainView()
}

