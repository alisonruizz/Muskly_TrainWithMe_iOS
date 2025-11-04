import SwiftUI

struct ShopScreen: View {
    @StateObject private var viewModel = ShopViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            // --- Monedas ---
            HStack(alignment: .center) {
                Image("img14")
                    .resizable()
                    .frame(width: 45, height: 45)
                Text("\(viewModel.coins)")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.yellow)
                Spacer()
            }

            // --- Nombre del personaje ---
            Text(viewModel.characterName)
                .font(.system(size: 35, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)

            // --- Imagen del personaje ---
            Image("img10")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .padding(.top, 8)

            // --- Tabs ---
            HStack {
                TabItem(title: "Inventory",
                        isSelected: viewModel.selectedTab == "Inventory") {
                    viewModel.selectTab("Inventory")
                }
                TabItem(title: "Shop",
                        isSelected: viewModel.selectedTab == "Shop") {
                    viewModel.selectTab("Shop")
                }
            }
            .padding(.top, 8)

            // --- Contenido dinámico ---
            if viewModel.selectedTab == "Shop" {
                ShopSection(items: viewModel.shopItems) { item in
                    viewModel.showBuyDialog(for: item)
                }
            } else {
                InventorySection(items: viewModel.inventoryItems) { item in
                    viewModel.toggleEquip(item)
                }
            }

        }
        .padding(16)
        .background(Color("SecondaryContainer").edgesIgnoringSafeArea(.all))
        .alert(item: $viewModel.itemToBuy) { item in
            Alert(
                title: Text("Confirm Purchase"),
                message: Text("Are you sure you want to buy \(item.name)?"),
                primaryButton: .default(Text("Yes")) {
                    viewModel.confirmPurchase(item)
                },
                secondaryButton: .cancel {
                    viewModel.dismissDialog()
                }
            )
        }
    }
}

// MARK: - Componentes

struct TabItem: View {
    let title: String
    let isSelected: Bool
    let onClick: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 30))
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(.white)
                .onTapGesture { onClick() }

            if isSelected {
                Rectangle()
                    .fill(Color.green)
                    .frame(height: 3)
            } else {
                Spacer().frame(height: 3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ShopSection: View {
    let items: [Item]
    let onBuy: (Item) -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                      spacing: 12) {
                ForEach(items) { item in
                    ShopItem(item: item) {
                        onBuy(item)
                    }
                }
            }
        }
    }
}

struct ShopItem: View {
    let item: Item
    let onBuy: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: item.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .foregroundColor(.white)
            Text(item.name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            HStack {
                Text("\(item.price)")
                    .foregroundColor(.yellow)
                    .font(.system(size: 18, weight: .semibold))
                Image("img14_png")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
            Button(action: onBuy) {
                Text("Buy")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(12)
    }
}

struct InventorySection: View {
    let items: [Item]
    let onToggleEquip: (Item) -> Void

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                      spacing: 12) {
                ForEach(items) { item in
                    InventoryItem(item: item) {
                        onToggleEquip(item)
                    }
                }
            }
        }
    }
}

struct InventoryItem: View {
    let item: Item
    let onToggleEquip: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: item.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .foregroundColor(.white)
            Text(item.name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Button(action: onToggleEquip) {
                Text(item.isEquipped ? "Quit" : "Equip")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(item.isEquipped ? Color.red : Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview {
    ShopScreen()
}
