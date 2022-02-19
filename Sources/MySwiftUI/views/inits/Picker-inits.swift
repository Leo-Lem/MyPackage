//
//  File.swift
//  
//
//  Created by Leopold Lemmermann on 17.02.22.
//

import SwiftUI

public extension Picker {
    //MARK: - hashable item id
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
    
    //MARK: - identifiable items
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
    
    //MARK: - integer range
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
