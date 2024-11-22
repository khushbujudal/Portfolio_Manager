//
//  Upstox_AssignmentTests.swift
//  Upstox_AssignmentTests
//
//  Created by Khushbu Judal on 12/11/24.
//

import XCTest
@testable import Upstox_Assignment

class PortfolioViewControllerTest: XCTestCase {
    
    func testCurrentValueCalculation() {
        let holdings = [
            Holding(symbol: "AAPL", ltp: 150.0, quantity: 10, avgPrice: 140.0, close: 155.0),
            Holding(symbol: "GOOG", ltp: 2800.0, quantity: 5, avgPrice: 2700.0, close: 2850.0)
        ]
        let portfolio = Portfolio(userHolding: holdings)
        
        let currentValue = portfolio.currentValue
        
        XCTAssertEqual(currentValue, 15500.0, "The current value should be correctly calculated.")
    }
    
    func testTotalInvestmentCalculation() {
        let holdings = [
            Holding(symbol: "AAPL", ltp: 150.0, quantity: 10, avgPrice: 140.0, close: 155.0),
            Holding(symbol: "GOOG", ltp: 2800.0, quantity: 5, avgPrice: 2700.0, close: 2850.0)
        ]
        let portfolio = Portfolio(userHolding: holdings)
        
        let totalInvestment = portfolio.totalInvestment
        
        XCTAssertEqual(totalInvestment, 14900.0, "The total investment should be correctly calculated.")
    }
    
    func testTotalPnLCalculation() {
        let holdings = [
            Holding(symbol: "AAPL", ltp: 150.0, quantity: 10, avgPrice: 140.0, close: 155.0),
            Holding(symbol: "GOOG", ltp: 2800.0, quantity: 5, avgPrice: 2700.0, close: 2850.0)
        ]
        let portfolio = Portfolio(userHolding: holdings)
        
        let totalPnL = portfolio.totalPnL
        
        XCTAssertEqual(totalPnL, 600.0, "The total P&L should be correctly calculated.")
    }
    
    func testTodaysPnLCalculation() {
        let holdings = [
            Holding(symbol: "AAPL", ltp: 150.0, quantity: 10, avgPrice: 140.0, close: 155.0),
            Holding(symbol: "GOOG", ltp: 2800.0, quantity: 5, avgPrice: 2700.0, close: 2850.0)
        ]
        let portfolio = Portfolio(userHolding: holdings)
        
        let todaysPnL = portfolio.todaysPnL
        
        XCTAssertEqual(todaysPnL, 300.0, "Today's P&L should be correctly calculated.")
    }
}
