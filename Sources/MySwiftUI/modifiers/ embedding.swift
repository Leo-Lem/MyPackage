//
//  WebLink.swift
//  WordScramble
//
//  Created by Leopold Lemmermann on 25.12.21.
//

import SwiftUI

//MARK: - wraps the view in a link to a given url
public extension View {
    func link(to url: URL) -> some View { Link(destination: url) { self } }
    func eraseToAnyView() -> AnyView { AnyView(self) }
    func embedInNavigation() -> some View { NavigationView(content: { self }) }
}

//MARK: - Previews
struct View_linkToURL_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, world!").link(to: URL(string: "https://www.hello.com")!)
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .link(to: URL(string: "https://www.hello.com")!)
        }
        .frame(maxHeight: 300)
    }
}