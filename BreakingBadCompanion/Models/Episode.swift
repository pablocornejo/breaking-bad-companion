//
//  Episode.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 5/6/21.
//

import Foundation

class Season: Identifiable {
    var id: String { season }
    let season: String
    var episodes: [Episode]
    
    init(season: String, episodes: [Episode]) {
        self.season = season
        self.episodes = episodes
    }
}

struct Episode: Codable {
    let episodeId: Int
    let title, season, airDate: String
    let characters: [String]
    let episode, series: String
}

extension Episode: Identifiable {
    var id: Int { episodeId }
}
