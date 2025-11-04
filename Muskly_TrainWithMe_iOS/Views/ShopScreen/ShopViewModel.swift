import SwiftUI

// Modelo de datos para cada ítem
struct Item: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: Int
    let icon: String
    var isEquipped: Bool = false
}

// ViewModel principal
class ShopViewModel: ObservableObject {
    @Published var coins: Int = 500
    @Published var characterName: String = "Musk"
    @Published var selectedTab: String = "Shop"
    @Published var shopItems: [Item] = [
        Item(name: "Sunglasses", price: 80, icon: "eye"),
        Item(name: "Scarf", price: 120, icon: "scissors")
    ]
    @Published var inventoryItems: [Item] = [
        Item(name: "T-shirt", price: 0, icon: "tshirt"),
        Item(name: "Cap", price: 0, icon: "person.crop.circle")
    ]
    @Published var itemToBuy: Item? = nil

    // --- Funciones de negocio ---
    func selectTab(_ tab: String) {
        selectedTab = tab
    }

    func showBuyDialog(for item: Item) {
        itemToBuy = item
    }

    func dismissDialog() {
        itemToBuy = nil
    }

    func confirmPurchase(_ item: Item) {
        if coins >= item.price {
            coins -= item.price
            shopItems.removeAll { $0 == item }
            inventoryItems.append(item)
        }
        itemToBuy = nil
    }

    func toggleEquip(_ item: Item) {
        inventoryItems = inventoryItems.map {
            if $0.name == item.name {
                var updated = $0
                updated.isEquipped.toggle()
                return updated
            } else {
                return $0
            }
        }
    }

    func addCoins(_ amount: Int) {
        coins += amount
    }
}
