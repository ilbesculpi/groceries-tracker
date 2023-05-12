//
//  ShoppingCartView.swift
//  GroceriesTracker
//
//  Created by Ilbert Esculpi on 9/5/23.
//

import SwiftUI

struct ShoppingCartView: View {
    
    var viewModel: ShoppingCartView.ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Shopping Cart")
                .font(.largeTitle)
            productList
            cartSummary
            footer
        }
    }
    
    var productList: some View {
        List {
            ForEach(viewModel.items) { item in
                HStack(alignment: .top) {
                    Image("ProductPlaceholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80)
                    VStack(alignment: .leading) {
                        Text(item.product.title)
                        Text("$\(item.product.unitPrice)")
                        Text("$\(item.subtotal)")
                    }
                    .padding(.horizontal, 8)
                    .frame(width: .infinity)
                }
                .padding(.all, 8)
            }
        }
        .listStyle(.inset)
    }
    
    var cartSummary: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Subtotal")
                Text(viewModel.subtotal)
            }
            HStack {
                Text("Total taxes")
                Text(viewModel.totalTaxes)
            }
            HStack {
                Text("Total Shipping")
                Text(viewModel.totalShipping)
            }
             HStack {
                Text("Total")
                    .bold()
                Text(viewModel.total)
                    .bold()
            }
        }
        .frame(width: .infinity)
    }
    
    var footer: some View {
        HStack {
            Text(viewModel.total)
                .font(.caption)
                .bold()
            Button() {
                
            } label: {
                Text("Proceed")
            }
        }
    }
}

struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        let products: [Product] = [
            Product(id: "fake-id-1", title: "Milk", sku: "2002LY", unitPrice: 5),
            Product(id: "fake-id-2", title: "Eggs", sku: "2004FG", unitPrice: 1.5),
            Product(id: "fake-id-3", title: "Napkins", sku: "20AA60", unitPrice: 4)
        ]
        let items: [CartItem] = [
            CartItem(product: products[0], quantity: 1),
            CartItem(product: products[1], quantity: 6),
            CartItem(product: products[2], quantity: 1),
        ]
        let cart = ShoppingCart.from(list: items)
        let viewModel = ShoppingCartView.ViewModel(with: cart)
        ShoppingCartView(viewModel: viewModel)
    }
}
