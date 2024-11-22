//
//  Stock.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 19/11/24.
//

import Foundation

struct UserPortfolio: Codable {
    var data: Portfolio?
}

struct Portfolio: Codable {
    var userHolding: [Holding]?
}

struct Holding: Codable {
    let symbol: String
    let ltp: Double
    let quantity: Int
    let avgPrice: Double
    let close: Double
}

extension Portfolio {
    var currentValue: Double {
        userHolding?.reduce(0) { $0 + ($1.ltp * Double($1.quantity)) } ?? 0
    }

    var totalInvestment: Double {
        userHolding?.reduce(0) { $0 + ($1.avgPrice * Double($1.quantity)) } ?? 0
    }

    var totalPnL: Double {
        currentValue - totalInvestment
    }

    var todaysPnL: Double {
        userHolding?.reduce(0) { $0 + ((Double($1.close) - $1.ltp) * Double($1.quantity)) } ?? 0
    }
}
