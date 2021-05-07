//
//  EpisodesViewModel.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 5/6/21.
//

import Foundation
import Combine

class EpisodesViewModel: ObservableObject {
    private var allEpisodes: [Episode] = [] {
        didSet {
            episodes = allEpisodes
            seasons = makeSeasons(from: episodes)
        }
    }
    @Published var episodes: [Episode] = []
    @Published var seasons: [Season] = []
    
    private let network: NetworkManager = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        fetchEpisodes()
    }
    
    func fetchEpisodes() {
        let url = URL(string: "https://www.breakingbadapi.com/api/episodes/")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        network
            .getDecodable(from: url, with: decoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("***", completion)
            } receiveValue: { (characters: [Episode]) in
                self.allEpisodes = characters
            }
            .store(in: &cancellables)
    }
    
    private func makeSeasons(from episodes: [Episode]) -> [Season] {
        var seasons: [Season] = []
        
        for episode in episodes {
            let adjustedSeason = episode.season.trimmingCharacters(in: .whitespaces)
            if let existingSeason = seasons.first(where: { adjustedSeason == $0.season }) {
                existingSeason.episodes.append(episode)
            } else {
                seasons.append(Season(season: adjustedSeason, episodes: [episode]))
            }
        }
        
        for season in seasons {
            season.episodes.sort { $0.episode < $1.episode }
        }
        
        return seasons
    }
}
