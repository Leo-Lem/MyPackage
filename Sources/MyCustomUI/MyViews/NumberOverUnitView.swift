//
//  NumberOverUnitView.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 06.01.22.
//

import SwiftUI
import MyOthers

struct NumberOverUnitView: View {
    let number: Int, unit: LocalizationUnit
    
    var body: some View {
        VStack {
            Text("\(number)").font(.headline)
            Text(localizeUnit(number, label: unit) ).font(.caption2)
        }
    }
}

//MARK: - Previews
struct NumberOverUnitView_Previews: PreviewProvider {
    static var previews: some View {
        NumberOverUnitView(number: 1, unit: .points)
    }
}
