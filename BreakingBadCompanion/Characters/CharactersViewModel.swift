//
//  CharactersViewModel.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import Foundation
import Combine
import SwiftUI

class CharactersViewModel: ObservableObject {
    private var allCharacters: [Character] = []
    @Published var characters: [Character] = []
    @Published var selectedSeason: Int = 0 {
        didSet {
            characters = allCharacters.filter { selectedSeason == 0 || $0.appearance.contains(selectedSeason) }
        }
    }
    
    private let network: NetworkManager = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        refreshCharacters()
    }
    
    func refreshCharacters() {
        let url = URL(string: "https://www.breakingbadapi.com/api/characters/")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        network.get(from: url, with: decoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("***", completion)
            } receiveValue: { (characters: [Character]) in
                self.allCharacters = characters
                self.selectedSeason = 0
            }
            .store(in: &cancellables)
    }
}
