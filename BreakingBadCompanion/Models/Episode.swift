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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try episodeId = container.decode(Int.self, forKey: .episodeId)
        try title = container.decode(String.self, forKey: .title)
        try season = container.decode(String.self, forKey: .season).trimmingCharacters(in: .whitespaces) // Custom init implemented to correct this
        try airDate = container.decode(String.self, forKey: .airDate)
        try characters = container.decode([String].self, forKey: .characters)
        try episode = container.decode(String.self, forKey: .episode)
        try series = container.decode(String.self, forKey: .series)
    }
    
    init(episodeId: Int, title: String, season: String, airDate: String, characters: [String], episode: String, series: String) {
        self.episodeId = episodeId
        self.title = title
        self.season = season
        self.airDate = airDate
        self.characters = characters
        self.episode = episode
        self.series = series
    }
}

extension Episode: Identifiable {
    var id: Int { episodeId }
}
