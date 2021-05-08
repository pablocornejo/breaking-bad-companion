//
//  ContentView.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import SwiftUI

struct CharactersListView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingFilter: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if showingFilter {
                    HStack {
                        Text("Season").font(.caption)
                        Picker(selection: $appState.selectedSeason, label: Text("Season")) {
                            ForEach(0..<6) { index in
                                Text(index == 0 ? "All" : "\(index)").tag(index)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                }
                List(appState.characters) { character in
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
            withAnimation { showingFilter.toggle() }
        } label: {
            Image(systemName: showingFilter ?
                    "line.horizontal.3.decrease.circle.fill" :
                    "line.horizontal.3.decrease.circle")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
            .environmentObject(AppState())
    }
}
