import SwiftUI

enum NavRoutes: String, CaseIterable {
    case home = "home"
    case train = "train"
    case tips = "tips"
    case goals = "goals"
    case shop = "shop"
}

struct AppNavigation: View {
    @State private var selectedTab: NavRoutes = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            // Contenido principal según la pestaña seleccionada
            Group {
                switch selectedTab {
                case .home:
                    TrainStartScreen()
                case .train:
                    TrainView()
                case .tips:
                    TipsView()
                case .goals:
                    GoalsScreen()
                case .shop:
                    ShopScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("SecundaryContainer").ignoresSafeArea())

            // 👇 Aquí se muestra tu barra personalizada blanca
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}
