//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 08.02.22.
//

import SwiftUI

public extension DatePicker {
    init(
        label: String = "",
        _ date: Binding<Date>,
        from: Date? = nil, to: Date? = nil,
        comps: DatePicker<Text>.Components = .date
    ) where Label == Text {
        switch (from, to) {
        case (nil, nil): self.init(label, selection: date, displayedComponents: comps)
        case (_, nil): self.init(label, selection: date, in: from!..., displayedComponents: comps)
        case (nil, _): self.init(label, selection: date, in: ...to!, displayedComponents: comps)
        case (_, _): self.init(label, selection: date, in: from!...to!, displayedComponents: comps)
        }
    }
}
