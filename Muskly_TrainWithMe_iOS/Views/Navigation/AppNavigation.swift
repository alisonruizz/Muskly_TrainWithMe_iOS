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
        TabView(selection: $selectedTab) {
            // Pantalla Home
            TrainStartScreen()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(NavRoutes.home)
            
            // Pantalla Train
            /*TrainScreen()
                .tabItem {
                    Label("Train", systemImage: "figure.walk")
                }
                .tag(NavRoutes.train)
            
            // Pantalla Tips
            TipsScreen()
                .tabItem {
                    Label("Tips", systemImage: "list.bullet.rectangle")
                }
                .tag(NavRoutes.tips)
            */
            
            // Pantalla Goals
            GoalsScreen()
                .tabItem {
                    Label("Goals", systemImage: "star.fill")
                }
                .tag(NavRoutes.goals)
            
            // Pantalla Shop
            ShopScreen()
                .tabItem {
                    Label("Shop", systemImage: "cart.fill")
                }
                .tag(NavRoutes.shop)
        }
        .accentColor(Color("PrimaryColor")) // opcional, color de íconos activos
    }
}
