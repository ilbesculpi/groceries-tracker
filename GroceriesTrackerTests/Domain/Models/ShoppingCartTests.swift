//
//  ShoppingCartTests.swift
//  GroceriesTrackerTests
//
//  Created by Ilbert Esculpi on 9/5/23.
//

import XCTest
import Quick
import Nimble
@testable import GroceriesTracker

final class EmptyCartSpec: QuickSpec {
    
    override func spec() {
        
        let cart = ShoppingCart.empty()
        
        describe("an empty cart") {
            it("has no products") {
                expect(cart.items.isEmpty).to(beTrue())
                expect(cart.total).to(equal(0))
                expect(cart.subTotal).to(equal(0))
                expect(cart.taxes).to(equal(0))
                expect(cart.discounts).to(equal(0))
                expect(cart.productCount).to(equal(0))
            }
        }
    }
}

final class ShoppingCartSpec: QuickSpec {
    
    override func spec() {
        var cart: ShoppingCart!
        
        describe("an empty cart") {
            
            beforeEach {
                cart = ShoppingCart.empty()
            }
            
            describe("adding products") {
                
                it("add products") {
                    do {
                        try cart.add(ShoppingCartTests.milk)
                        try cart.add(ShoppingCartTests.apples, quantity: 4)
                        expect(cart.items.isEmpty).to(beFalse())
                        expect(cart.productCount).to(equal(5))
                    }
                    catch {
                        fail("cart.add() failed")
                    }
                }
                
                it("same product adds quantities") {
                    do {
                        try cart.add(ShoppingCartTests.milk)
                        try cart.add(ShoppingCartTests.milk, quantity: 3)
                        expect(cart.productCount).to(equal(4))
                        expect(cart.total).to(equal(8))
                    }
                    catch {
                        fail("cart.add() failed")
                    }
                }
                
                it("does not allow adding 0 items") {
                    do {
                        try cart.add(ShoppingCartTests.milk, quantity: 0)
                        fail("should not succeed")
                    }
                    catch {
                        expect(error).to(matchError(ShoppingCartError.invalidQuantity))
                    }
                }
                
                it("does not allow adding negative items") {
                    do {
                        try cart.add(ShoppingCartTests.milk, quantity: -2)
                        fail("should not succeed")
                    }
                    catch {
                        expect(error).to(matchError(ShoppingCartError.invalidQuantity))
                    }
                }
            }
            
            describe("no taxes") {
                
                it("calc totals") {
                    do {
                        try cart.add(ShoppingCartTests.milk, quantity: 2)   // 2x$2
                        try cart.add(ShoppingCartTests.apples, quantity: 6) // 6x$1
                        expect(cart.subTotal).to(equal(10))
                        expect(cart.total).to(equal(10))
                    }
                    catch {
                        fail("cart.add() failed")
                    }
                }
            }
            
            describe("taxes") {
                
                it ("calc totals") {
                    do {
                        try cart.add(ShoppingCartTests.napkins, quantity: 5)   // 5x$5 ~ 10% taxes
                        expect(cart.subTotal).to(equal(25))
                        expect(cart.taxes).to(equal(2.5))
                        expect(cart.total).to(equal(27.5))
                    }
                    catch {
                        fail("cart.add() failed")
                    }
                }
            }
        }
        
    }
}

final class ShoppingCartTests {
    
    static let milk = Product(
        id: "fake-milk-id",
        title: "Milk",
        sku: "9800DEC",
        unitPrice: 2
    )
    
    static let eggs = Product(
        id: "fake-eggs-id",
        title: "Eggs",
        sku: "829210E",
        unitPrice: 0.5
    )
    
    static let apples = Product(
        id: "fake-apple-id",
        title: "Apple",
        sku: "654201",
        unitPrice: 1
    )
    
    static let napkins = Product(
        id: "fake-napkins-id",
        title: "Napkins",
        sku: "86540GE",
        unitPrice: 5,
        taxes: 0.1
    )
}
