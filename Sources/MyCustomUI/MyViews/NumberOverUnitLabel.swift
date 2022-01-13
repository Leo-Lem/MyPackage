//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.01.22.
//

import SwiftUI

struct NumberOverUnitLabel<N: CustomStringConvertible & CVarArg>: View {
    let number: N, unit: LocalizationUnit
    
    var body: some View {
        VStack {
            Text("\(number.description)").font(.headline)
            Text(localizeUnit(number, label: unit) ).font(.caption2)
        }
    }
}

//MARK: - Previews
struct NumberOverUnitLabel_Previews: PreviewProvider {
    static var previews: some View {
        NumberOverUnitLabel(number: 1, unit: .points)
    }
}
