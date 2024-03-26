//
//  Decimal+Utils.swift
//  BankeyApp
//
//  Created by Mykhailo Kotyk on 26.03.2024.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
