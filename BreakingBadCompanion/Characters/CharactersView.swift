//
//  ContentView.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: <#T##_#>) {
                    Text(character.name)
                }
            }
            .navigationTitle("Characters")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: .init())
    }
}
