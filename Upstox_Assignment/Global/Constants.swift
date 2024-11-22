//
//  Constants.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 22/11/24.
//

import Foundation

struct Constants {
    struct SummaryView {
        static let expandedHeight : CGFloat = 200
        static let collapsedHeight : CGFloat = 60
        static let profitLoss = "Profit & Loss*"
        static let currentValue = "Current Value*"
        static let totalInvestment = "Total Investment*"
        static let todaysPNL = "Today's PNL*"
    }
    
    struct HoldingCell {
        static let cellIdentifier = "HoldingCell"
        static let qtyLabel = "Qty: "
        static let ltpLabel = "LTP: ₹"
        static let pnlLabel = "P&L: ₹"
    }

    struct PortfolioView {
        static let title = "Portfolio"
    }
    
    struct errorMessages {
        static let invalidURL = "The URL is invalid. Please check and try again."
        static let requestFailed = "The request failed: "
        static let noData = "No data received from the server."
        static let decodingError = "Failed to decode the response: "
        static let unknownError = "An unknown error occurred. Please try again later."
    }
}
