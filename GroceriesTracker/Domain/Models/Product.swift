//
//  Product.swift
//  GroceriesTracker
//
//  Created by Ilbert Esculpi on 9/5/23.
//

import Foundation

struct Product: Identifiable {
    
    var id: String
    var title: String
    var sku: String
    var description: String?
    var category: String?
    var unitPrice: Double
    var taxes: Double?
    var available: Int?
    
}
