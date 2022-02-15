//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 10.02.22.
//

import SwiftUI

public extension Text {
    init<Content: StringProtocol>(
        _ content: Content,
        font: Font?,
        color: Color? = nil
    ) {
        self.init(content)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        _ image: Image,
        font: Font? = nil,
        color: Color? = nil
    ) {
        self.init(image)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        _ dates: ClosedRange<Date>,
        font: Font? = nil,
        color: Color? = nil
     ) {
        self.init(dates)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        _ interval: DateInterval,
        font: Font? = nil,
        color: Color? = nil
    ) {
        self.init(interval)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        _ attributedContent: AttributedString,
        font: Font?,
        color: Color? = nil
    ) {
        self.init(attributedContent)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init<Style: FormatStyle>(
        _ input: Style.FormatInput,
        format: Style,
        font: Font? = nil,
        color: Color? = nil
    ) where Style.FormatInput: Equatable, Style.FormatOutput == String {
        self.init(input, format: format)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        _ date: Date,
        style: DateStyle,
        font: Font? = nil,
        color: Color? = nil
    ) {
        self.init(date, style: style)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init<T: ReferenceConvertible>(
        _ subject: T,
        formatter: Formatter,
        font: Font? = nil,
        color: Color? = nil
    ) {
        self.init(subject, formatter: formatter)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        font: Font? = nil,
        color: Color? = nil
    ) {
        self.init(key, tableName: tableName, bundle: bundle, comment: comment)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
    
    init(
        verbatim: String,
        font: Font? = nil,
        color: Color? = nil
    ) {
        self.init(verbatim: verbatim)
        
        self = self
            .font(font)
            .foregroundColor(color)
    }
}
