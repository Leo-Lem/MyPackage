//
//  FilteringList.swift
//  
//
//  Created by Leopold Lemmermann on 25.02.22.
//

import SwiftUI
import MyCollections
import MyOthers

/***/
public struct FilteringList<Data: RandomAccessCollection, RowContent: View>: View where Data.Element: Hashable {
    let list: [Data.Element]
    
    let filterKeyPaths: [KeyPath<Data.Element, String>],
        sortKeyPath: KeyPath<Data.Element, AnyComparable>?
    
    let prompt: String
    
    let rowContent: (Data.Element) -> RowContent
    
    public var body: some View {
        List(filteredList, id: \.self, rowContent: rowContent)
            .searchable(text: $search, prompt: prompt)
    }
    
    @State private var search: String = ""
    private var filteredList: [Data.Element] { sort(filter(list)) }
    
    public init(
        _ data: Data,
        prompt: String = "Type to filter",
        filterBy filterKeyPaths: KeyPath<Data.Element, String>...,
        sortBy sortKeyPath: KeyPath<Data.Element, AnyComparable>? = nil,
        @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent
    ) {
        self.list = Array(data)
        self.prompt = prompt
        self.filterKeyPaths = filterKeyPaths
        self.sortKeyPath = sortKeyPath
        self.rowContent = rowContent
    }
}

private extension FilteringList {
    
    private func sort(_ list: [Data.Element]) -> [Data.Element] {
        if let sortKeyPath = sortKeyPath {
            return list.sorted(by: sortKeyPath)
        } else {
            return list
        }
    }
    
    private func filter(_ list: [Data.Element]) -> [Data.Element] {
        let filter = search.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if filter.isEmpty {
            return list
        } else if let strings = list as? [String]  {
            return strings.filter { element in
                element.localizedCaseInsensitiveContains(filter)
            } as? [Data.Element] ?? list
        } else {
            return list.filter { element in
                !filterKeyPaths.allSatisfy { filterKeyPath in
                    !element[keyPath: filterKeyPath]
                        .localizedCaseInsensitiveContains(filter)
                }
            }
        }
    }
    
}

//MARK: - Previews
struct FilteringList_Previews: PreviewProvider {
    static var previews: some View {
        FilteringList(["Hello", "world", "and", "friends!"], rowContent: Text.init)
            .embedInNavigation()
    }
}
