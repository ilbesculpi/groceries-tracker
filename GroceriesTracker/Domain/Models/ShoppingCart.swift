//
//  ShoppingCart.swift
//  GroceriesTracker
//
//  Created by Ilbert Esculpi on 9/5/23.
//

import Foundation

enum ShoppingCartError: Error {
    case invalidQuantity
}

class ShoppingCart: ObservableObject {
    
    @Published
    public private (set) var items: [CartItem]
    var total: Double = 0
    var subtotal: Double = 0
    var discounts: Double = 0
    var taxes: Double = 0
    var shipping: Double = 0
    var productCount: Int {
        return items.reduce(0) {
            $0 + $1.quantity
        }
    }
    
    private init() {
        items = []
    }
    
    private init(with items: [CartItem]) {
        self.items = items
        calculate()
    }
    
    static func empty() -> ShoppingCart {
        return ShoppingCart()
    }
    
    static func from(list items: [CartItem]) -> ShoppingCart {
        return ShoppingCart(with: items)
    }
    
    func add(_ product: Product, quantity: Int = 1) throws {
        
        if quantity < 1 {
            throw ShoppingCartError.invalidQuantity
        }
        
        if let current = items.first(where: { $0.product.id == product.id }) {
            // product already on cart: add quantities
            current.quantity += quantity
        }
        else {
            // first time added
            let item = CartItem(product: product, quantity: quantity)
            items.append(item)
        }
        calculate()
    }
    
    private func calculate() {
        discounts = items.reduce(0) {
            return $0 + $1.discount
        }
        taxes = items.reduce(0) {
            return $0 + $1.taxes
        }
        subtotal = items.reduce(0) {
            return $0 + $1.subtotal
        }
        total = subtotal + taxes - discounts
    }
}

class CartItem: Identifiable {
    
    var id: String {
        product.id
    }
    let product: Product
    var quantity: Int
    var discount: Double = 0
    
    var unitPrice: Double {
        return product.unitPrice
    }
    
    var taxes: Double {
        guard let taxes = product.taxes else {
            return 0
        }
        return Double(quantity) * unitPrice * taxes
    }
    
    var subtotal: Double {
        return Double(quantity) * unitPrice
    }
    
    var total: Double {
        return subtotal + taxes - discount
    }
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
    
    func increase() {
        quantity += 1
    }
    
    func decrease() {
        quantity -= 1
    }
}
