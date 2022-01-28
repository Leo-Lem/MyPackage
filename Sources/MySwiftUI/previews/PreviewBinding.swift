//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 26.01.22.
//

import SwiftUI

struct PreviewBinding<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }
}

