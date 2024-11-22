//
//  Double+Extensions.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 20/11/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func percentChange() -> String {
        return String(format: "%.2f", self) // Adjust for percentage calculation logic if needed
    }
}
