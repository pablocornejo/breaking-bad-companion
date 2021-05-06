//
//  ContentView.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: CharactersViewModel
    @State private var showingFilter: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if showingFilter {
                    Picker(selection: $viewModel.selectedSeason, label: Text("Season")) {
                        Text("All").tag(0)
                        ForEach(1..<6) {
                            Text("\($0)").tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                List(viewModel.characters) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.headline)
                            Text(character.nickname)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarItems(trailing: filterButton)
            .navigationTitle("Characters")
            .listStyle(PlainListStyle())
        }
    }
    
    private var filterButton: some View {
        Button {
            withAnimation {
                showingFilter.toggle()
            }
        } label: {
            Image(systemName: "line.horizontal.3.decrease.circle")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView(viewModel: .init())
    }
}
