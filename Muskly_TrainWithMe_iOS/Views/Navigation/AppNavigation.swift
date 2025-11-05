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
                    //TrainView()
                    Color.green.opacity(0.1).overlay(Text("Train Screen"))
                case .tips:
                    //TipsView()
                    Color.orange.opacity(0.1).overlay(Text("Tips Screen"))
                case .goals:
                    GoalsScreen()
                case .shop:
                    ShopScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("SecondaryContainer").ignoresSafeArea())

            // 👇 Aquí se muestra tu barra personalizada blanca
            BottomNavigationBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}
