//
//  ImageLoader.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published private(set) var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map(UIImage.init)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                withAnimation {
                    self?.image = image
                }
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
