//
//  AppState.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 5/8/21.
//

import Foundation
import Combine

class AppState: ObservableObject {
    private var allCharacters: [Character] = []
    private var allEpisodes: [Episode] = [] {
        didSet {
            episodes = allEpisodes
            seasons = makeSeasons(from: episodes, for: currentSeries)
        }
    }
    @Published var characters: [Character] = []
    @Published var selectedSeason: Int = 0 {
        didSet {
            characters = allCharacters.filter { selectedSeason == 0 || $0.appearance.contains(selectedSeason) }
        }
    }
    @Published var episodes: [Episode] = []
    @Published var seasons: [Season] = []
    
    private let currentSeries: String = "Breaking Bad"
    private let network: NetworkManager = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        refreshCharacters()
        fetchEpisodes()
    }
    
    func refreshCharacters() {
        let url = URL(string: "https://www.breakingbadapi.com/api/characters/")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        network
            .getDecodable(from: url, with: decoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("***", completion)
            } receiveValue: { (characters: [Character]) in
                self.allCharacters = characters
                self.selectedSeason = 0
            }
            .store(in: &cancellables)
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
    
    private func makeSeasons(from episodes: [Episode], for series: String) -> [Season] {
        var seasons: [Season] = []
        
        for episode in episodes where episode.series == series {
            if let existingSeason = seasons.first(where: { episode.season == $0.season }) {
                existingSeason.episodes.append(episode)
            } else {
                seasons.append(Season(season: episode.season, episodes: [episode]))
            }
        }
        
        for season in seasons {
            season.episodes.sort { $0.episode < $1.episode }
        }
        
        return seasons
    }
}
