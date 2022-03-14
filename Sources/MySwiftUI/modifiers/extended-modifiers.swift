//
//  extended-modifiers.swift
//  
//
//  Created by Leopold Lemmermann on 23.02.22.
//

import SwiftUI

// MARK: - (animation(_ value))
public extension View {
    
    /// Applies the default animation to the view when the specified value changes.
    /// - Parameter value: A value to monitor for changes.
    /// - Returns: A view that applies the default animation to this view whenever `value` changes.
    func animation<V: Equatable>(
        _ value: V
    ) -> some View {
        self
            .animation(.default, value: value)
    }
    
}

// MARK: - (disabled(color))
public extension View {
    
    /// Colors the disabled view with the provided color
    ///
    /// ```
    /// Text("My tappable text...")
    ///     .onTapGesture { /*do something*/ }
    ///     .disabled(myCondition, color: .gray)
    /// ```
    ///
    /// - Parameters:
    ///   - condition: A Boolean value that determines whether users can interact with this view.
    ///   - color: The color to apply.
    /// - Returns: A view that controls whether users can interact with this view and is colored according to its interaction state.
    func disabled(
        _ condition: Bool,
        color: Color
    ) -> some View {
        self
            .disabled(condition)
            .if(condition) { view in
                view.foregroundColor(color)
            }
    }
    
}

#if canImport(UIKit)
// MARK: - (cornerRadius)
extension View {
    
    /// <#Description#>
    /// - Parameters:
    ///   - radius: <#radius description#>
    ///   - corners: <#corners description#>
    /// - Returns: <#description#>
    public func cornerRadius(
        _ radius: CGFloat = 10,
        corners: UIRectCorner
    ) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func cornerRadius<Style: ShapeStyle>(_ cornerRadius: Double, border: (style: Style, width: Double)) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(border.style, lineWidth: border.width)
            )
    }
    
}

/// <#Description#>
private struct RoundedCorner: Shape {
    let radius: CGFloat, corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        )
    }
}
#endif

// MARK: - (background(image, opacity))
public extension View {
    
    /// <#Description#>
    /// - Parameters:
    ///   - image: <#image description#>
    ///   - opacity: <#opacity description#>
    /// - Returns: <#description#>
    func background(image: String, opacity: Double = 1) -> some View {
        self.background {
                Image(decorative: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(opacity)
            }
    }
    
}

// MARK: - (alert(optional)
//TODO: add documentation
public extension View {
    
    //MARK: with action and message
    func alert<T, A, M>(
        _ item: Binding<T?>,
        title: LocalizedStringKey = "",
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where A: View, M: View  {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: actions,
            message: message
        )
    }
    
    func alert<T, S, A, M>(
        _ item: Binding<T?>,
        title: S = "",
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where S: StringProtocol, A: View, M: View {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: actions,
            message: message
        )
    }
    
    func alert<T, A, M>(
        _ item: Binding<T?>,
        title: Text = Text(""),
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where A: View, M: View {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: actions,
            message: message
        )
    }
    
    //MARK: variations
    func alert<T, A>(_ item: Binding<T?>, title: Text = Text(""), @ViewBuilder actions: (T) -> A) -> some View where A: View {
        alert(item, title: title, actions: actions, message: {_ in})
    }
    
    func alert<T, A>(_ item: Binding<T?>, title: LocalizedStringKey = "", @ViewBuilder actions: (T) -> A) -> some View where A: View  {
        alert(item, title: title, actions: actions, message: {_ in})
    }
    
    func alert<T, S, A>(_ item: Binding<T?>, title: S = "",@ViewBuilder actions: (T) -> A) -> some View where S: StringProtocol, A: View  {
        alert(item, title: title, actions: actions, message: {_ in})
    }
    
    func alert<T, M>(_ item: Binding<T?>, title: Text = Text(""), @ViewBuilder message: (T) -> M) -> some View where M: View {
        alert(item, title: title, actions: {_ in}, message: message)
    }
    
    func alert<T, M>(_ item: Binding<T?>, title: LocalizedStringKey = "", @ViewBuilder message: (T) -> M) -> some View where M: View {
        alert(item, title: title, actions: {_ in}, message: message)
    }
    
    func alert<T, S, M>(_ item: Binding<T?>, title: S = "", @ViewBuilder message: (T) -> M) -> some View where S: StringProtocol, M: View {
        alert(item, title: title, actions: {_ in}, message: message)
    }
    
    func alert<T>(_ item: Binding<T?>, title: Text = Text("")) -> some View {
        alert(item, title: title, actions: {_ in}, message: {_ in})
    }
    
    func alert<T>(_ item: Binding<T?>, title: LocalizedStringKey = "") -> some View {
        alert(item, title: title, actions: {_ in}, message: {_ in})
    }
    
    func alert<T, S>(_ item: Binding<T?>, title: S = "") -> some View where S: StringProtocol {
        alert(item, title: title, actions: {_ in}, message: {_ in})
    }
    
    // MARK: with title method
    func alert<T, A, M>(
        _ item: Binding<T?>,
        title: (T) -> Text,
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where A: View, M: View {
        alert(item, title: item.wrappedValue == nil ? Text("") : title(item.wrappedValue!), actions: actions, message: message)
    }
    
    func alert<T, A, M>(
        _ item: Binding<T?>,
        title: (T) -> LocalizedStringKey,
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where A: View, M: View {
        alert(item, title: item.wrappedValue == nil ? "" : title(item.wrappedValue!), actions: actions, message: message)
    }
    
    func alert<T, S, A, M>(
        _ item: Binding<T?>,
        title: (T) -> S,
        @ViewBuilder actions: (T) -> A,
        @ViewBuilder message: (T) -> M
    ) -> some View where S: StringProtocol, A: View, M: View {
        alert(item, title: item.wrappedValue == nil ? "" : title(item.wrappedValue!), actions: actions, message: message)
    }
    
    //MARK: variations
    func alert<T, A: View>(_ item: Binding<T?>, title: (T) -> Text, @ViewBuilder actions: (T) -> A) -> some View {
        alert(item, title: title, actions: actions, message: {_ in})
    }
    
    func alert<T, A: View>(_ item: Binding<T?>, title: (T) -> LocalizedStringKey, @ViewBuilder actions: (T) -> A) -> some View {
        alert(item, title: title, actions: actions, message: {_ in})
    }
    
    func alert<T, S: StringProtocol, A: View>(_ item: Binding<T?>, title: (T) -> S,@ViewBuilder actions: (T) -> A) -> some View {
        alert(item, title: title, actions: actions, message: {_ in})
    }
    
    func alert<T, M: View>(_ item: Binding<T?>, title: (T) -> Text, @ViewBuilder message: (T) -> M) -> some View {
        alert(item, title: title, actions: {_ in}, message: message)
    }
    
    func alert<T, M: View>(_ item: Binding<T?>, title: (T) -> LocalizedStringKey, @ViewBuilder message: (T) -> M) -> some View {
        alert(item, title: title, actions: {_ in}, message: message)
    }
    
    func alert<T, S: StringProtocol, M: View>(_ item: Binding<T?>, title: (T) -> S, @ViewBuilder message: (T) -> M) -> some View {
        alert(item, title: title, actions: {_ in}, message: message)
    }
    
    func alert<T>(_ item: Binding<T?>, title: (T) -> Text) -> some View {
        alert(item, title: title, actions: {_ in}, message: {_ in})
    }
    
    func alert<T>(_ item: Binding<T?>, title: (T) -> LocalizedStringKey) -> some View {
        alert(item, title: title, actions: {_ in}, message: {_ in})
    }
    
    func alert<T, S: StringProtocol>(_ item: Binding<T?>, title: (T) -> S) -> some View {
        alert(item, title: title, actions: {_ in}, message: {_ in})
    }
    
}
