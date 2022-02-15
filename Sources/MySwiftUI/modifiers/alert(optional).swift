//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI

//MARK: makes alerts usable without requiring a boolean property
public extension View {
    
    //MARK: - basic
    func alert<T>(
        _ titleKey: LocalizedStringKey,
        item: Binding<T?>
    ) -> some View {
        alert(
            titleKey,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: {_ in}
        )
    }
    
    func alert<T, S: StringProtocol>(
        _ title: S,
        item: Binding<T?>
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: {_ in}
        )
    }
    
    func alert<T>(
        _ title: Text,
        item: Binding<T?>
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: {_ in}
        )
    }
    
    //MARK: - with actions
    func alert<T, A: View>(
        _ titleKey: LocalizedStringKey,
        item: Binding<T?>,
        actions: (T) -> A
    ) -> some View {
        alert(
            titleKey,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: actions
        )
    }
    
    func alert<T, S: StringProtocol, A: View>(
        _ title: S,
        item: Binding<T?>,
        actions: (T) -> A
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: actions
        )
    }
    
    func alert<T, A: View>(
        _ title: Text,
        item: Binding<T?>,
        actions: (T) -> A
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: actions
        )
    }
    
    //MARK: - with message
    func alert<T, M: View>(
        _ titleKey: LocalizedStringKey,
        item: Binding<T?>,
        message: (T) -> M
    ) -> some View {
        alert(
            titleKey,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: {_ in},
            message: message
        )
    }
    
    func alert<T, S: StringProtocol, M: View>(
        _ title: S,
        item: Binding<T?>,
        message: (T) -> M
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: {_ in},
            message: message
        )
    }
    
    func alert<T, M: View>(
        _ title: Text,
        item: Binding<T?>,
        message: (T) -> M
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: {_ in},
            message: message
        )
    }
    
    //MARK: - with actions and message
    func alert<T, A: View, M: View>(
        _ titleKey: LocalizedStringKey,
        item: Binding<T?>,
        actions: (T) -> A,
        message: (T) -> M
    ) -> some View {
        alert(
            titleKey,
            isPresented: Binding<Bool>(
                get: { item.wrappedValue != nil },
                set: { _ in item.wrappedValue = nil }
            ),
            presenting: item.wrappedValue,
            actions: actions,
            message: message
        )
    }
    
    func alert<T, S: StringProtocol, A: View, M: View>(
        _ title: S,
        item: Binding<T?>,
        actions: (T) -> A,
        message: (T) -> M
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: actions,
            message: message
        )
    }
    
    func alert<T, A: View, M: View>(
        _ title: Text,
        item: Binding<T?>,
        actions: (T) -> A,
        message: (T) -> M
    ) -> some View {
        alert(
            title,
            isPresented: Binding<Bool>(get: { item.wrappedValue != nil }, set: { _ in item.wrappedValue = nil }),
            presenting: item.wrappedValue,
            actions: actions,
            message: message
        )
    }
    
}
