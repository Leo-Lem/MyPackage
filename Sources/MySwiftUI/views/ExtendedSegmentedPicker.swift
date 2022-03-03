//
//  SwiftUIView.swift
//  
//
//  Created by Leopold Lemmermann on 13.02.22.
//

import SwiftUI

/***/
public struct ExtendedSegmentedPicker<Content: View, Selection: Hashable>: View {
    
    @Binding var selection: Selection
    let options: (`left`: [Selection], segmented: [Selection], `right`: [Selection]),
        labels: (segmented: (_ selection: Selection) -> Content, menu: (_ selection: Selection) -> Content)
    
    public var body: some View {
        HStack {
            if !options.left.isEmpty { menu(options.left) }
            
            if !options.segmented.isEmpty {
                Picker("", selection: $selection) {
                    ForEach(options.segmented, id: \.self) { option in
                        labels.segmented(option)
                            .tag(option)
                    }
                }
            }
            
            if !options.right.isEmpty { menu(options.right) }
        }
        .pickerStyle(.segmented)
        .foregroundColor(.primary)
    }
    
    ///
    private func menu(_ options: [Selection]) -> some View {
        Menu(systemImage: "ellipsis.circle\(options.contains(selection) ? ".fill" : "")") {
            ForEach(options, id: \.self) { option in
                Button(action: { selection = option } , label: { labels.menu(option) })
            }
        }
    }
    
}

public extension ExtendedSegmentedPicker {
    
    /***/
    init(
        _ selection: Binding<Selection>,
        options: (`left`: [Selection], segmented: [Selection], `right`: [Selection]),
        segmentLabel: @escaping (_ selection: Selection) -> Content,
        menuLabel: @escaping (_ selection: Selection) -> Content
    ) {
        self.init(
            selection: selection,
            options: options,
            labels: (segmentLabel, menuLabel)
        )
    }
    
    /***/
    init(
        _ selection: Binding<Selection>,
        options: [Selection], segments: Int = 3, startAt: Int = 0,
        segmentLabel: @escaping (_ selection: Selection) -> Content,
        menuLabel: @escaping (_ selection: Selection) -> Content
    ) {
        self.init(
            selection,
            options: (
                Array(options.prefix(startAt)),
                Array(options.dropFirst(startAt).prefix(segments)),
                Array(options.dropFirst(startAt + segments))
            ),
            segmentLabel: segmentLabel,
            menuLabel: menuLabel
        )
    }
    
    /***/
    init(
        _ selection: Binding<Selection>,
        options: (`left`: [Selection], segmented: [Selection], `right`: [Selection]),
        label: @escaping (_ selection: Selection) -> Content
    ) {
        self.init(
            selection,
            options: options,
            segmentLabel: label, menuLabel: label
        )
    }
    
    /***/
    init(
        _ selection: Binding<Selection>,
        options: [Selection], segments: Int = 3, startAt: Int = 0,
        label: @escaping (_ selection: Selection) -> Content
    ) {
        self.init(
            selection,
            options: options, segments: segments, startAt: startAt,
            segmentLabel: label, menuLabel: label
        )
    }
    
}

//MARK: - Previews
struct ExtendedSegmentedPicker_Previews: PreviewProvider {
    static let selection = 2
    
    static var previews: some View {
        PreviewBinding(selection) { selection in
            ExtendedSegmentedPicker(selection, options: Array(2...50)) {
                Text("\($0)")
            } menuLabel: {
                Text("\($0)")
            }
        }
    }
}
