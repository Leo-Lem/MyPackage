//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import SwiftUI

// MARK: - (Button)
public extension Button {
    
    /// <#Description#>
    enum PrimitiveAction {
        case toggle(Binding<Bool>),
             `true`(Binding<Bool>),
             `false`(Binding<Bool>)
        
        var action: () -> Void {
            switch self {
            case .toggle(let binding): return { binding.wrappedValue.toggle() }
            case .true(let binding): return { binding.wrappedValue = true }
            case .false(let binding): return { binding.wrappedValue = false }
            }
        }
    }
    
}

public extension Button where Label == Text {
    
    /// Creates a button that generates its label from a string.
    /// - Parameters:
    ///    - title: A string that describes the purpose of the button's `action`.
    ///    - primitiveAction: A `PrimitiveAction` from which the real action is derived.
    init<S: StringProtocol>(
        _ title: @autoclosure () -> S,
        primitiveAction: PrimitiveAction
    ) {
        self.init(title(), action: primitiveAction.action)
    }
    
    /// Creates a button that generates its label from a string.
    /// - Parameters:
    ///    - title: A `LocalizedStringKey` describing the purpose of the button's `action`.
    ///    - primitiveAction: A `PrimitiveAction` from which the real action is derived.
    init(
        _ title: @autoclosure () -> LocalizedStringKey,
        primitiveAction: PrimitiveAction
    ) {
        self.init(title(), action: primitiveAction.action)
    }
    
}

public extension Button where Label == Image {
    
    /// <#Description#>
    /// - Parameters:
    ///   - systemImage: <#systemImage description#>
    ///   - action: <#action description#>
    init(
        systemImage: String,
        action: @escaping () -> Void
    )  {
        self.init(action: action) { Image(systemName: systemImage) }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - systemImage: <#systemImage description#>
    ///   - primitiveAction: <#primitiveAction description#>
    init(
        systemImage: String,
        primitiveAction: PrimitiveAction
    ) {
        self.init(systemImage: systemImage, action: primitiveAction.action)
    }
    
}


public extension Button {
    
    /// <#Description#>
    /// - Parameters:
    ///   - primitiveAction: <#primitiveAction description#>
    ///   - label: <#label description#>
    init(
        primitiveAction: PrimitiveAction,
        label: @escaping () -> Label
    ) {
        self.init(action: primitiveAction.action, label: label)
    }
    
}

// MARK: - (DatePicker)
public extension DatePicker {
    
    /// <#Description#>
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

// MARK: - (ForEach)
import MyNumbers
public extension ForEach where Data == Range<Int>, ID == Int, Content: View {
    
    /// <#Description#>
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - id: <#id description#>
    ///   - content: <#content description#>
    init(_ data: ClosedRange<Int>, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (ID) -> Content) {
        self.init((data.lowerBound)..<(data.upperBound+), id: id, content: content)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - content: <#content description#>
    init(_ data: ClosedRange<Int>, @ViewBuilder content: @escaping (ID) -> Content) {
        self.init(data, id: \.self, content: content)
    }
    
}

// MARK: - (Menu)
public extension Menu where Label == Image {
    
    /// <#Description#>
    /// - Parameters:
    ///   - systemImage: <#systemImage description#>
    ///   - content: <#content description#>
    ///   - primaryAction: <#primaryAction description#>
    init(systemImage: String, content: () -> Content, primaryAction: (() -> Void)? = nil) {
        if let primaryAction = primaryAction {
            self.init(content: content, label: { Image(systemName: systemImage) }, primaryAction: primaryAction)
        } else {
            self.init(content: content, label: { Image(systemName: systemImage) })
        }
    }
    
}

// MARK: - (Picker)
public extension Picker {
    
    //MARK: hashable item id
    init<S, Data, ID, ItemContent>(
        _ title: S,
        selection: Binding<SelectionValue>,
        items: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> ItemContent
    ) where
        Label == Text, S: StringProtocol,
        Content == ForEach<Data, ID, ItemContent>,
        Data: RandomAccessCollection,
        ID: Hashable,
        ItemContent: View {
        self.init(title, selection: selection, content: { ForEach(items, id: id, content: content) })
    }
    
    init<Data, ID, ItemContent>(
        _ titleKey: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        items: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> ItemContent
    ) where
        Label == Text,
        Content == ForEach<Data, ID, ItemContent>,
        Data: RandomAccessCollection,
        ID: Hashable,
        ItemContent: View  {
        self.init(titleKey, selection: selection, content: { ForEach(items, id: id, content: content) })
    }
    
    init<Data, ID, ItemContent>(
        selection: Binding<SelectionValue>,
        items: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> ItemContent,
        label: () -> Label
    ) where
        Content == ForEach<Data, ID, ItemContent>,
        Data: RandomAccessCollection,
        ID: Hashable,
        ItemContent: View  {
        self.init(selection: selection, content: { ForEach(items, id: id, content: content) }, label: label)
    }
    
    //MARK: identifiable items
    init<S, Data, ID, ItemContent>(
        _ title: S,
        selection: Binding<SelectionValue>,
        items: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> ItemContent
    ) where
        Label == Text, S: StringProtocol,
        Content == ForEach<Data, ID, ItemContent>,
        Data: RandomAccessCollection,
        Data.Element: Identifiable,
        ID == Data.Element.ID,
        ItemContent: View {
        self.init(title, selection: selection, content: { ForEach(items, content: content) })
    }
    
    init<Data, ID, ItemContent>(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        items: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> ItemContent
    ) where
        Label == Text,
        Content == ForEach<Data, ID, ItemContent>,
        Data: RandomAccessCollection,
        Data.Element: Identifiable,
        ID == Data.Element.ID,
        ItemContent: View {
        self.init(title, selection: selection, content: { ForEach(items, content: content) })
    }
    
    init<Data, ID, ItemContent>(
        selection: Binding<SelectionValue>,
        items: Data,
        id: KeyPath<Data.Element, ID>,
        content: @escaping (Data.Element) -> ItemContent,
        label: () -> Label
    ) where
        Content == ForEach<Data, ID, ItemContent>,
        Data: RandomAccessCollection,
        Data.Element: Identifiable,
        ID == Data.Element.ID,
        ItemContent: View {
        self.init(selection: selection, content: { ForEach(items, content: content) }, label: label)
    }
    
    //MARK: integer range
    init<S, ItemContent>(
        _ title: S,
        selection: Binding<SelectionValue>,
        items: Range<Int>,
        content: @escaping (Int) -> ItemContent
    ) where
        Label == Text, S: StringProtocol,
        Content == ForEach<Range<Int>, Int, ItemContent>,
        ItemContent: View {
        self.init(title, selection: selection, content: { ForEach(items, content: content) })
    }
    
    init<ItemContent>(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        items: Range<Int>,
        content: @escaping (Int) -> ItemContent
    ) where
        Label == Text,
        Content == ForEach<Range<Int>, Int, ItemContent>,
        ItemContent: View {
        self.init(title, selection: selection, content: { ForEach(items, content: content) })
    }
    
    init<ItemContent>(
        selection: Binding<SelectionValue>,
        items: Range<Int>,
        content: @escaping (Int) -> ItemContent,
        label: () -> Label
    ) where
        Content == ForEach<Range<Int>, Int, ItemContent>,
        ItemContent: View {
        self.init(selection: selection, content: { ForEach(items, content: content) }, label: label)
    }
}

// MARK: - (Shape)
public extension Shape where Self == Rectangle {
    
    /// <#Description#>
    static var rectangle: Self { Rectangle() }
    
}

public extension Shape where Self == RoundedRectangle {
    
    /// <#Description#>
    /// - Parameters:
    ///   - cornerRadius: <#cornerRadius description#>
    ///   - style: <#style description#>
    /// - Returns: <#description#>
    static func roundedRectangle(
        cornerRadius: CGFloat,
        style: RoundedCornerStyle = .circular
    ) -> Self {
        RoundedRectangle(cornerRadius: cornerRadius, style: style)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - cornerSize: <#cornerSize description#>
    ///   - style: <#style description#>
    /// - Returns: <#description#>
    static func roundedRectangle(
        cornerSize: CGSize,
        style: RoundedCornerStyle = .circular
    ) -> Self {
        RoundedRectangle(cornerSize: cornerSize, style: style)
    }
    
}

public extension Shape where Self == Circle {
    
    /// <#Description#>
    static var circle: Circle { Circle() }
    
}

public extension Shape where Self == Ellipse {
    
    /// <#Description#>
    static var ellipse: Ellipse { Ellipse() }
    
}

public extension Shape where Self == Capsule {
    
    /// <#Description#>
    static var capsule: Capsule { Capsule() }
    
    /// <#Description#>
    /// - Parameter style: <#style description#>
    /// - Returns: <#description#>
    static func capsule(style: RoundedCornerStyle) -> Capsule {
        Capsule(style: style)
    }
    
}

// MARK: - (Text)
public extension Text {
    
    /// <#Description#>
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
    
    /// <#Description#>
    init<Content: StringProtocol>(
        _ content: Content,
        color: Color?
    ) {
        self.init(content)
        
        self = self.foregroundColor(color)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - image: <#image description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - dates: <#dates description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - interval: <#interval description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - attributedContent: <#attributedContent description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - date: <#date description#>
    ///   - style: <#style description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - subject: <#subject description#>
    ///   - formatter: <#formatter description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - key: <#key description#>
    ///   - tableName: <#tableName description#>
    ///   - bundle: <#bundle description#>
    ///   - comment: <#comment description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
    
    /// <#Description#>
    /// - Parameters:
    ///   - verbatim: <#verbatim description#>
    ///   - font: <#font description#>
    ///   - color: <#color description#>
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
