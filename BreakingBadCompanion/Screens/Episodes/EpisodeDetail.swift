//
//  EpisodeDetail.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 5/7/21.
//

import SwiftUI

struct EpisodeDetail: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title).font(.headline)
            Text("Season \(episode.season), episode \(episode.episode)")
            Text("Aired on \(episode.airDate)")
            Text(episode.characters.joined(separator: ", "))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(episode.title)
    }
}

struct EpisodeDetail_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetail(episode: Episode(episodeId: 1,
                                       title: "Some Episode",
                                       season: "1",
                                       airDate: "Apr 16, 2010",
                                       characters: ["Pablo", "Tefi"],
                                       episode: "1",
                                       series: "Breaking Bad"))
    }
}
