import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedTab: NavRoutes

    // Configuración de los íconos y etiquetas
    let items: [(NavRoutes, String, String)] = [
        (.home, "house.fill", "Home"),
        (.train, "figure.walk", "Train"),
        (.tips, "list.bullet.rectangle", "Tips"),
        (.goals, "star.fill", "Goals"),
        (.shop, "cart.fill", "Shop")
    ]

    var body: some View {
        HStack {
            ForEach(items, id: \.0) { route, icon, label in
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(selectedTab == route ? Color("Secundary") : Color.gray.opacity(0.6))

                    Text(label)
                        .font(.caption2)
                        .fontWeight(selectedTab == route ? .bold : .regular)
                        .foregroundColor(selectedTab == route ? Color("Secundary") : Color.gray.opacity(0.6))
                }
                .padding(.vertical, 8)
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selectedTab = route
                    }
                }
                Spacer()
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            // Fondo blanco con sombra suave y bordes redondeados
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }
}
