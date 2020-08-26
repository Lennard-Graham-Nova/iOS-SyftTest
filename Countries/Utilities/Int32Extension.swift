//
//  Int32Extension.swift
//  Countries
//
//  Created by Graham, Lennard on 26/08/2020.
//  Copyright © 2020 James Weatherley. All rights reserved.
//

import Foundation

extension Int32 {
    
    func formatLargeNumbers() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        return formattedNumber
    }
    
}
