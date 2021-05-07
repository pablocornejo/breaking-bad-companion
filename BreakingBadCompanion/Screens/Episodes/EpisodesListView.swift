//
//  EpisodesListView.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 5/6/21.
//

import SwiftUI

struct EpisodesListView: View {
    @ObservedObject var viewModel: EpisodesViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.seasons) { season in
                    Section(header: Text("Season " + season.season)) {
                        ForEach(season.episodes) { episode in
                            NavigationLink(destination: EpisodeDetail(episode: episode)) {
                                Text(episode.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Episodes")
        }
    }
}

struct EpisodesListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesListView(viewModel: .init())
    }
}
