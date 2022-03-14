//
//  new-modifiers.swift
//  
//
//  Created by Leopold Lemmermann on 05.01.22.
//

import SwiftUI

// MARK: - (if modifier)
public extension View {
    
    /// Applies view transformations only if condition evaluates to true.
    /// ```
    /// Text("Hello, World!")
    ///     .if(myCondition) { view in
    ///         view.foregroundColor(.red)
    ///     }
    /// //returns red text if myCondition evaluates to true
    /// ```
    /// - Parameters:
    ///   - condition: A boolean value for when the transformation should be applied.
    ///   - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
    /// - Returns: Some View, based on input parameters and Self type.
    @ViewBuilder func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder transform: (Self) -> Content
    ) -> some View {
        if condition() { transform(self) } else { self }
    }
    
    /// Applies view transformations only if condition evaluates to true.
    /// ```
    /// Text("Hello, World!")
    ///     .if(myCondition) { view in
    ///         view.foregroundColor(.red)
    ///     } else: { view in
    ///         view.font(.headline)
    ///     }
    /// //returns red text if myCondition evaluates to true,
    /// //otherwise text with headline font
    /// ```
    /// - Parameters:
    ///   - condition: A boolean value for when the transformation should be applied.
    ///   - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
    ///   - else: Another function parameter taking a view of Self type as parameter and returning some View Content.
    /// - Returns: Some View, based on input parameters and Self type.
    @ViewBuilder func `if`<C1: View, C2: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder transform: (Self) -> C1,
        @ViewBuilder `else` transform2: (Self) -> C2
    ) -> some View {
        if condition() { transform(self) } else {  transform2(self) }
    }
    
    /// Applies view transformations if a value is non-optional and provides the value in the transformation closure.
    /// ```
    /// Text("Hello, World!")
    ///     .if(let: anOptionalString) { view, unwrappedOptionalString in
    ///         view.navigationTitle(unwrappedOptionalString)
    ///     }
    /// //adds a navigationtitle displaying the unwrapped String if it is not nil
    /// ```
    /// - Parameters:
    ///   - optional: An optional parameter of arbitrary type.
    ///   - condition: An optional boolean condition, that (if not nil) will additionally determine whether to apply the transformation.
    ///   - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
    /// - Returns: Some View, based on the provided optional, transformation function and Self type.
    @ViewBuilder func `if`<T, Content: View>(
        `let` optional: T?,
        and condition: Bool? = nil,
        @ViewBuilder transform: (Self, T) -> Content
    ) -> some View {
        switch (optional, condition) {
        case (.some, .none), (.some, true): transform(self, optional!)
        default: self
        }
    }
    
    /// Applies view transformations if a value is non-optional and provides the value in the transformation closure.
    /// ```
    /// Text("Hello, World!")
    ///     .if(let: anOptionalString) { view, unwrappedOptionalString in
    ///         view.navigationTitle(unwrappedOptionalString)
    ///     } else: { view in
    ///         view.foregroundColor(.red)
    ///     }
    /// //adds a navigationtitle displaying the unwrapped String if it is not nil
    /// //otherwise changes the foregroundColor of the Text to red
    /// ```
    /// - Parameters:
    ///   - optional: An optional parameter of arbitrary type.
    ///   - condition: An optional boolean condition, that (if not nil) will additionally determine whether to apply the transformation.
    ///   - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
    ///   - else: Another function parameter taking a view of Self type as parameter and returning some View Content.
    /// - Returns: Some View, based on the provided optional, transformation function and Self type.
    @ViewBuilder func `if`<T, C1: View, C2: View>(
        `let` optional: T?,
        and condition: Bool? = nil,
        @ViewBuilder transform: (Self, T) -> C1,
        @ViewBuilder `else` transform2: (Self) -> C2
    ) -> some View {
        switch (optional, condition) {
        case (.none, _), (.some, false): transform2(self)
        case (.some, .none), (.some, true): transform(self, optional!)
        default: self
        }
    }
    
}

// MARK: - (group modifier)
public extension View {
  
    /// <#Description#>
    /// - Returns: <#description#>
    @ViewBuilder func group<Content: View>(
        @ViewBuilder transform: (Self) -> Content
    ) -> some View {
        transform(self)
    }
    
}

// MARK: - (link modifier)
public extension View {
    
    /// Wraps the view in a link to some url.
    /// ```
    /// Text("This leads to my link.")
    ///     .link(myURL)
    /// ```
    /// - Parameter url: The URL to link to.
    /// - Returns: A Link wrapping the view leading to the `url`.
    func link(_ url: URL) -> some View {
        Link(destination: url) { self }
    }
    
    
}

// MARK: - (eraseToAnyView modifier)
public extension View {
    
    /// Type-erases the view to AnyView.
    /// - Returns: The view type-erased to AnyView.
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
}

// MARK: - (embedInNavigation modifier)
public extension View {
    
    /// Embeds the view inside a NavigationView.
    /// ```
    /// Text("Hello, World!")
    ///     .padding()
    ///     .navigationTitle("My Content View")
    ///     .embedInNavigation()
    /// ```
    /// - Returns: A NavigationView containing the view.
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
    
    /// Embeds the view inside a NavigationView.
    /// ```
    /// Text("Hello, World!")
    ///     .padding()
    ///     .navigationTitle("My Content View")
    ///     .embedInNavigation { Text("Nothing to see here...") }
    /// ```
    /// - Parameter placeholder: A View as a fallback in column layout.
    /// - Returns: A NavigationView containing the view.
    func embedInNavigation<Placeholder: View>(
        @ViewBuilder _ placeholder: () -> Placeholder
    ) -> some View {
        NavigationView {
            self
            placeholder()
        }
    }
    
    /// Embeds the view inside a NavigationView.
    /// ```
    /// Text("Hello, World!")
    ///     .padding()
    ///     .navigationTitle("My Content View")
    ///     .embedInNavigation("Nothing to see here...")
    /// ```
    /// - Parameter placeholder: A localized string key to be displayed as a placeholder in column layout.
    /// - Returns: A NavigationView containing the view.
    func embedInNavigation(
        placeholder: LocalizedStringKey
    ) -> some View {
        NavigationView {
            self
            Text(placeholder)
        }
    }
    
    /// Embeds the view inside a NavigationView.
    /// ```
    /// Text("Hello, World!")
    ///     .padding()
    ///     .navigationTitle("My Content View")
    ///     .embedInNavigation("Nothing to see here...")
    /// ```
    /// - Parameter placeholder: A string to be displayed as a placeholder in column layout.
    /// - Returns: A NavigationView containing the view.
    func embedInNavigation<S: StringProtocol>(
        placeholder: S
    ) -> some View {
        NavigationView {
            self
            Text(placeholder)
        }
    }
    
}

// MARK: - (stacked modifier)
public extension View {
    
    /// <#Description#>
    /// - Parameters:
    ///   - position: <#position description#>
    ///   - total: <#total description#>
    /// - Returns: <#description#>
    func stacked(
        at position: Int,
        in total: Int
    ) -> some View {
        self.offset(x: 0, y: Double(total - position) * 10)
    }
    
}

// MARK: - (replace if)
public extension View {
    
    /// <#Description#>
    /// - Parameters:
    ///   - condition: <#condition description#>
    ///   - placeholder: <#placeholder description#>
    /// - Returns: <#description#>
    func replace<Content: View>(
        if condition: @autoclosure () -> Bool,
        placeholder: () -> Content
    ) -> some View {
        Group {
            if condition() {
                placeholder()
            } else {
                self
            }
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - condition: <#condition description#>
    ///   - placeholder: <#placeholder description#>
    /// - Returns: <#description#>
    func replace<S: StringProtocol>(
        if condition: @autoclosure () -> Bool,
        placeholder: S
    ) -> some View {
        Group {
            if condition() {
                Text(placeholder).foregroundColor(.secondary)
            } else {
                self
            }
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - condition: <#condition description#>
    ///   - placeholder: <#placeholder description#>
    /// - Returns: <#description#>
    func replace(
        if condition: @autoclosure () -> Bool,
        placeholder: LocalizedStringKey
    ) -> some View {
        Group {
            if condition() {
                Text(placeholder).foregroundColor(.secondary)
            } else {
                self
            }
        }
    }

}
