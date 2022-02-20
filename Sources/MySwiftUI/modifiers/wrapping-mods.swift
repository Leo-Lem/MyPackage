//
//  ConditionalHidden.swift
//  
//
//  Created by Leopold Lemmermann on 05.12.21.
//

import SwiftUI


public extension View {
    /**
     Applies view transformations only if condition evaluates to true.
     
     ```
     Text("Hello, World!")
        .if(myCondition) { view in
            view.foregroundColor(.red)
        }
     //returns red text if myCondition evaluates to true
     ```
     
     - returns: Some View, based on input parameters and Self type.
     - parameters:
        - condition: A boolean value for when the transformation should be applied.
        - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
     */
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        @ViewBuilder transform: (Self) -> Content
    ) -> some View {
        if condition { transform(self) } else { self }
    }
    
    /**
     Applies view transformations only if condition evaluates to true.
     
     ```
     Text("Hello, World!")
        .if(myCondition) { view in
            view.foregroundColor(.red)
        } else: { view in
            view.font(.headline)
        }
     //returns red text if myCondition evaluates to true,
     //otherwise text with headline font
     ```
     
     - returns: Some View, based on input parameters and Self type.
     - parameters:
        - condition: A boolean value for when the transformation should be applied.
        - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
        - else: Another function parameter taking a view of Self type as parameter and returning some View Content.
     */
    @ViewBuilder func `if`<C1: View, C2: View>(
        _ condition: Bool,
        @ViewBuilder transform: (Self) -> C1,
        @ViewBuilder `else` transform2: (Self) -> C2
    ) -> some View {
        if condition { transform(self) } else {  transform2(self) }
    }
    
    /**
     Applies view transformations if a value is non-optional.
     
     ```
     Text("Hello, World!")
        .if(let: anOptionalString) { view, unwrappedOptionalString in
            view.navigationTitle(unwrappedOptionalString)
        }
     //adds a navigationtitle displaying the unwrapped String if it is not nil
     ```
     
     - returns: Some View, based on input parameters and Self type.
     - parameters:
        - let: An optional parameter of arbitrary type.
        - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
     */
    @ViewBuilder func `if`<T, Content: View>(
        `let` optional: T?,
        @ViewBuilder transform: (Self, T) -> Content
    ) -> some View {
        if let optional = optional { transform(self, optional) } else { self }
    }
    
    /**
     Applies view transformations if a value is non-optional.
     
     ```
     Text("Hello, World!")
        .if(let: anOptionalString) { view, unwrappedOptionalString in
            view.navigationTitle(unwrappedOptionalString)
        } else: { view in
            view.foregroundColor(.red)
        }
     //adds a navigationtitle displaying the unwrapped String if it is not nil,
     //otherwise changes the foregroundColor of the Text to red
     ```
     
     - returns: Some View, based on input parameters and Self type.
     - parameters:
        - let: An optional parameter of arbitrary type.
        - transform: A function parameter taking a view of Self type as parameter and returning some View Content.
        - else: Another function parameter taking a view of Self type as parameter and returning some View Content.
     */
    @ViewBuilder func `if`<T, C1: View, C2: View>(
        `let` optional: T?,
        @ViewBuilder transform: (Self, T) -> C1,
        @ViewBuilder `else` transform2: (Self) -> C2
    ) -> some View {
        if let optional = optional { transform(self, optional) } else { transform2(self) }
    }
    
    //MARK: - group modifiers together (for better readability)
    @ViewBuilder func group<Content: View>(
        @ViewBuilder transform: (Self) -> Content
    ) -> some View {
        transform(self)
    }
}
