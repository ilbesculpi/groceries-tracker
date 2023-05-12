//
//  ShoppingCartViewModel.swift
//  GroceriesTracker
//
//  Created by Ilbert Esculpi on 9/5/23.
//

import Foundation

extension ShoppingCartView {
    
    class ViewModel: ObservableObject {
        
        private var cart: ShoppingCart
        
        @Published var total: String = "$0.00"
        @Published var subtotal: String = "$0.00"
        @Published var totalTaxes: String = "$0.00"
        @Published var totalShipping: String = "$0.00"
        @Published var items: [CartItem] = []
        
        init(with cart: ShoppingCart) {
            self.cart = cart
            self.total = formatAmount(cart.total)
            self.subtotal = formatAmount(cart.subtotal)
            self.items = cart.items
        }
        
        func formatAmount(_ value: Double, defalultValue: String = "$0.00") -> String {
            let formatter = NumberFormatter()
            formatter.locale = .current
            formatter.numberStyle = .currency
            guard let amount = formatter.string(from: value as NSNumber) else {
                return defalultValue
            }
            return amount
        }
        
    }
}
