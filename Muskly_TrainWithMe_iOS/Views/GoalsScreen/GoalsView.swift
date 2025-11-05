import SwiftUI

struct GoalsScreen: View {
    @StateObject private var viewModel = GoalsViewModel()
    @State private var sortOption: String = "All"
    @State private var rewardMessage: String = ""
    @State private var showReward: Bool = false

    var sortedGoals: [Goal] {
        switch sortOption {
        case "Completed":
            return viewModel.goals.filter { $0.completed }
        case "Pending":
            return viewModel.goals.filter { !$0.completed }
        default:
            return viewModel.goals
        }
    }

    var body: some View {
        ZStack {
            Color("SecondaryContainer").edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 12) {
                // Imagen y burbuja
                HStack(alignment: .top, spacing: 8) {
                    Image("img6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)

                    SpeechBubble {
                        Text("Muskly dares you!")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .padding(12)
                    
                    }
                    .frame(maxWidth: 200)
                }

                // Título y menú desplegable
                HStack {
                    Text("Your goals")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()

                    Menu {
                        Button("All") { sortOption = "All" }
                        Button("Completed") { sortOption = "Completed" }
                        Button("Pending") { sortOption = "Pending" }
                    } label: {
                        Label("Sort by: \(sortOption)", systemImage: "arrowtriangle.down.fill")
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)

                // Lista de metas
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(sortedGoals) { goal in
                            GoalItem(goal: goal) {
                                viewModel.completeGoal(goal) { reward in
                                    rewardMessage = "🎉 Congratulations, you earned \(reward) chigui-coins!"
                                    showReward = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        showReward = false
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)

                Spacer()
            }
            .padding(.top, 16)

            // Notificación emergente
            if showReward {
                VStack {
                    Spacer()
                    Text(rewardMessage)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.easeInOut(duration: 0.5), value: showReward)
                }
            }
        }
    }
}

// MARK: - Componentes de UI

struct GoalItem: View {
    let goal: Goal
    let onClick: () -> Void

    var body: some View {
        HStack {
            Text(goal.description)
                .font(.system(size: 18))
                .foregroundColor(goal.completed ? .black : .white)
                .lineLimit(2)
            Spacer()
            if !goal.completed {
                HStack(spacing: 4) {
                    Text("\(goal.reward)")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.yellow)
                    Image("img14")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(goal.completed ? Color.green.opacity(0.6) : Color.blue.opacity(0.6))
        .cornerRadius(12)
        .onTapGesture { onClick() }
    }
}

// Burbuja de diálogo (speech bubble)
struct SpeechBubble<Content: View>: View {
    var content: () -> Content

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            content()
                .background(Color.gray)
                .cornerRadius(16)
                .overlay(
                    Triangle()
                        .fill(Color.gray)
                        .frame(width: 20, height: 20)
                        .offset(x: 20, y: 10),
                    alignment: .bottomLeading
                )
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    GoalsScreen()
}
