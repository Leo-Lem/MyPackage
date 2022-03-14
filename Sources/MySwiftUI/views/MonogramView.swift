//
//  MonogramView.swift
//  
//
//  Created by Leopold Lemmermann on 11.03.22.
//

import SwiftUI

public struct MonogramView: View {
    
    public let name: String,
               formatter: PersonNameComponentsFormatter
    
    public var body: some View { makeMonogram() }
    
    public init(
        _ name: String,
        formatter: PersonNameComponentsFormatter = .init()
    ) {
        self.name = name
        self.formatter = formatter
    }
    
    private struct CircledMonogram<Content: View>: View {
        var content: Content

        var body: some View {
            content
                .font(.system(.largeTitle, design: .rounded))
                .padding()
                .background(Color.yellow)
                .clipShape(.circle)
        }
    }
    
    func makeMonogram() -> some View {
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            let abbreviatedName = formatter.string(from: components)

            if abbreviatedName.count == 2 {
                return CircledMonogram(content: Image(systemName: "person.fill")).eraseToAnyView()
            }
        }

        return CircledMonogram(content: Text(name)).eraseToAnyView()
    }
    
}

#if DEBUG
// MARK: - (Previews)
struct MonogramView_Previews: PreviewProvider {
    static var previews: some View {
        MonogramView("Leopold Lemmermann")
    }
}
#endif
