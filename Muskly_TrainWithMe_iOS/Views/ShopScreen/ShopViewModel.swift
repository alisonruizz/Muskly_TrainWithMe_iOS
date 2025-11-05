import SwiftUI

struct Item: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: Int
    let icon: String
    var isEquipped: Bool = false
}

class ShopViewModel: ObservableObject {
    @Published var coins: Int = 500
    @Published var characterName: String = "Musk"
    @Published var selectedTab: String = "Shop"
    
    @Published var shopItems: [Item] = [
        Item(name: "Sunglasses", price: 80, icon: "eyeglasses"),
        Item(name: "Scarf", price: 120, icon: "cloud.drizzle"),
    ]
    
    @Published var inventoryItems: [Item] = [
        Item(name: "T-shirt", price: 0, icon: "tshirt"),
        Item(name: "Cap", price: 0, icon: "hat.cap.fill")
    ]
    
    @Published var itemToBuy: Item? = nil
    
    // Estado de accesorios visibles
    @Published var isSunglassesEquipped = false
    @Published var isCapEquipped = false
    @Published var isTshirtEquipped = false

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
            var updated = $0
            if $0.name == item.name {
                updated.isEquipped.toggle()
                applyEquipment(for: updated)
            }
            return updated
        }
    }

    func applyEquipment(for item: Item) {
        switch item.name {
        case "Sunglasses":
            isSunglassesEquipped = item.isEquipped
        case "Cap":
            isCapEquipped = item.isEquipped
        case "T-shirt":
            isTshirtEquipped = item.isEquipped
        default:
            break
        }
    }

    func addCoins(_ amount: Int) {
        coins += amount
    }
}
