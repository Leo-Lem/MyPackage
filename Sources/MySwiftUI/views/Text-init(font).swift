//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 10.02.22.
//

import SwiftUI

public extension Text {
    init<Content: StringProtocol>(_ content: Content, font: Font) {
        self.init(content)
        self = self.font(font)
    }
    
    init(_ image: Image, font: Font) {
        self.init(image)
        self = self.font(font)
    }
    
    init(_ dates: ClosedRange<Date>, font: Font) {
        self.init(dates)
        self = self.font(font)
    }
    
    init(_ interval: DateInterval, font: Font) {
        self.init(interval)
        self = self.font(font)
    }
    
    init(_ attributedContent: AttributedString, font: Font) {
        self.init(attributedContent)
        self = self.font(font)
    }
    
    init<Style: FormatStyle>(
        _ input: Style.FormatInput,
        format: Style,
        font: Font
    ) where Style.FormatInput: Equatable, Style.FormatOutput == String {
        self.init(input, format: format)
        self = self.font(font)
    }
    
    init(_ date: Date, style: DateStyle, font: Font) {
        self.init(date, style: style)
        self = self.font(font)
    }
    
    init<T: ReferenceConvertible>(_ subject: T, formatter: Formatter, font: Font) {
        self.init(subject, formatter: formatter)
        self = self.font(font)
    }
    
    init(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        font: Font
    ) {
        self.init(key, tableName: tableName, bundle: bundle, comment: comment)
        self = self.font(font)
    }
    
    init(verbatim: String, font: Font) {
        self.init(verbatim: verbatim)
        self = self.font(font)
    }
}
