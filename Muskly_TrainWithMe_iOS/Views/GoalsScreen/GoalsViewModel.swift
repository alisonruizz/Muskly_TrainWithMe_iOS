import SwiftUI

// Modelo de meta (Goal)
struct Goal: Identifiable, Equatable {
    let id: Int
    let description: String
    let reward: Int
    var completed: Bool = false
}

// ViewModel principal
class GoalsViewModel: ObservableObject {
    @Published var goals: [Goal] = [
        Goal(id: 1, description: "Do 50 squats", reward: 10),
        Goal(id: 2, description: "Do over 2 hours of training", reward: 15),
        Goal(id: 3, description: "Have 5 day streak", reward: 25),
        Goal(id: 4, description: "Train all the muscles in a week", reward: 30),
        Goal(id: 5, description: "Have a 14 day streak", reward: 50),
        Goal(id: 6, description: "Do 100 push-ups", reward: 20),
        Goal(id: 7, description: "Run 10 km", reward: 40)
    ]
    
    @Published var coins: Int = 0
    
    init() {
        resetGoalsIfMonday()
    }
    
    func completeGoal(_ goal: Goal, onRewardEarned: (Int) -> Void) {
        if let index = goals.firstIndex(where: { $0.id == goal.id }), !goals[index].completed {
            goals[index].completed = true
            coins += goal.reward
            onRewardEarned(goal.reward)
        }
    }
    
    private func resetGoalsIfMonday() {
        let weekday = Calendar.current.component(.weekday, from: Date())
        // En iOS, el lunes = 2
        if weekday == 2 {
            for i in goals.indices {
                goals[i].completed = false
            }
        }
    }
    
    func resetAllGoals() {
        for i in goals.indices {
            goals[i].completed = false
        }
    }
}
