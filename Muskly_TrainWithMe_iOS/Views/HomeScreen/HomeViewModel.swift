import SwiftUI

/// ViewModel que controla el estado de la pantalla de inicio de entrenamiento.
class TrainStartViewModel: ObservableObject {
    @Published var xpProgress: CGFloat = 0.6
    @Published var currentXP: Int = 370
    @Published var maxXP: Int = 500

    @Published var showFirstSetDialog: Bool = false
    @Published var showRestDialog: Bool = false

    /// Aumenta la experiencia actual (solo ejemplo)
    func addXP(_ amount: Int) {
        currentXP = min(currentXP + amount, maxXP)
        xpProgress = CGFloat(currentXP) / CGFloat(maxXP)
    }

    /// Resetea el progreso de experiencia
    func resetXP() {
        currentXP = 0
        xpProgress = 0.0
    }

    /// Lógica cuando el usuario termina el primer set
    func finishFirstSet() {
        showFirstSetDialog = false
        showRestDialog = true
        addXP(50) // Ejemplo: gana 50 XP
    }

    /// Lógica para cerrar el diálogo de descanso
    func endRest() {
        showRestDialog = false
    }
}
