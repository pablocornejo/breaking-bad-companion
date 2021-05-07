//
//  ContentView.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 5/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CharactersListView(viewModel: .init())
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Characters")
                }
            EpisodesListView(viewModel: .init())
                .tabItem {
                    Image(systemName: "person.2.square.stack")
                    Text("Episodes")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
