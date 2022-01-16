//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import SwiftUI

public struct NumberOverUnitLabel<N: CustomStringConvertible & CVarArg>: View {
    public let number: N, unit: LocalizationUnit
    
    public var body: some View {
        VStack {
            Text("\(number.description)").font(.headline)
            Text(localizeUnit(number, label: unit) ).font(.caption2)
        }
    }
    
    public init(_ number: N, _ unit: LocalizationUnit) {
        self.number = number
        self.unit = unit
    }
}

//MARK: - Previews
struct NumberOverUnitLabel_Previews: PreviewProvider {
    static var previews: some View {
        NumberOverUnitLabel(number: 1, unit: .points)
    }
}
