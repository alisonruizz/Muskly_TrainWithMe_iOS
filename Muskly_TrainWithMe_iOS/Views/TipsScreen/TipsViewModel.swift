
import SwiftUI

// Modelo de datos
struct Tip: Identifiable {
    let id = UUID()
    let category: String
    let short: String
    let details: String
}

// ViewModel con estado observable
@MainActor
class TipsViewModel: ObservableObject {
    @Published var expandedIndex: String? = nil
    @Published var categoriesWithTips: [(String, [Tip])] = []

    private let allTips: [Tip] = [
        Tip(category: "Exercise", short: "Warm up 5–10 min", details: "Before lifting heavy or doing intense cardio, always warm up 5–10 minutes to prepare your muscles and joints."),
        Tip(category: "Exercise", short: "Progressive overload", details: "Gradually increase weight, reps, or intensity to keep making progress. Small improvements add up!"),
        Tip(category: "Exercise", short: "Don’t train same muscles daily", details: "Give your muscles at least 48h to recover before hitting them again."),
        Tip(category: "Exercise", short: "Compound lifts matter", details: "Squats, deadlifts, bench press, and pull-ups train multiple muscles at once. Use them as the base of your routine."),
        Tip(category: "Exercise", short: "Change routine every 6–8 weeks", details: "Your body adapts quickly. Add variation to avoid plateaus."),
        Tip(category: "Exercise", short: "Don’t go to failure every set", details: "Save failure training for your last set of an exercise."),
        Tip(category: "Exercise", short: "Cardio is also important", details: "Even if your goal is muscle growth, cardio keeps your heart healthy and improves recovery."),
        Tip(category: "Exercise", short: "Track more than weight", details: "Measure strength, endurance, and body composition, not just the scale."),
        Tip(category: "Exercise", short: "Stay hydrated", details: "Drink water during training to avoid cramps and fatigue."),
        Tip(category: "Exercise", short: "Consistency beats intensity", details: "Training regularly is more important than going all-out once in a while."),
        
        Tip(category: "Technique", short: "Form over weight", details: "Better to lift less but correctly. Good form prevents injuries and maximizes gains."),
        Tip(category: "Technique", short: "Breathe correctly", details: "Inhale when lowering, exhale when lifting. Don’t hold your breath unless using bracing."),
        Tip(category: "Technique", short: "Engage your core", details: "A strong core stabilizes your spine and improves almost every lift."),
        Tip(category: "Technique", short: "Control the movement", details: "Avoid bouncing or using too much momentum. Time under tension builds strength."),
        Tip(category: "Technique", short: "Full range of motion", details: "When safe, use the complete ROM to maximize muscle activation."),
        Tip(category: "Technique", short: "Stop if sharp pain", details: "Discomfort is fine, sharp pain is not. Know the difference."),
        Tip(category: "Technique", short: "Adjust equipment", details: "Make sure machines are set to your body size to avoid bad mechanics."),
        Tip(category: "Technique", short: "Don’t overuse the mirror", details: "Check form if needed, but also learn to feel the movement."),
        Tip(category: "Technique", short: "Master basics first", details: "Squats, deadlifts, and presses are fundamental—learn them well."),
        Tip(category: "Technique", short: "Stretch smart", details: "Dynamic stretches before training, static stretches after training."),
        
        Tip(category: "Rest", short: "Muscle grows while resting", details: "Recovery is where the real gains happen, not in the gym."),
        Tip(category: "Rest", short: "Sleep 7–9h", details: "Lack of sleep kills recovery, performance, and motivation."),
        Tip(category: "Rest", short: "Don’t train right before bed", details: "Hard training close to bedtime can interfere with quality sleep."),
        Tip(category: "Rest", short: "Respect rest days", details: "They are part of the program, not laziness."),
        Tip(category: "Rest", short: "Stretch after training", details: "Helps reduce stiffness and keeps mobility."),
        Tip(category: "Rest", short: "Use deload weeks", details: "Every 6–8 weeks, reduce load/volume to recover long-term."),
        Tip(category: "Rest", short: "Active recovery works", details: "Walking, swimming, or yoga on rest days helps circulation and repair."),
        Tip(category: "Rest", short: "Avoid too much caffeine", details: "Stimulants late in the day ruin sleep quality."),
        Tip(category: "Rest", short: "Nutrition = recovery", details: "Eat enough protein and carbs to rebuild muscles."),
        Tip(category: "Rest", short: "Listen to your body", details: "If you’re exhausted, skipping one workout may be better than pushing through.")
    ]
    
    init() {
        refreshTips()
    }

    func toggleExpanded(index: String) {
        expandedIndex = expandedIndex == index ? nil : index
    }

    func refreshTips() {
        let grouped = Dictionary(grouping: allTips, by: { $0.category })
        categoriesWithTips = grouped.map { (key, tips) in
            (key, Array(tips.shuffled().prefix(2)))
        }
    }
}
