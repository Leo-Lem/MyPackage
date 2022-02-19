//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI

public extension View {
    
    //MARK: - with action and message
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
    
    //MARK: - with title method
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
