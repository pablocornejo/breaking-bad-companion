//
//  CharacterDetailView.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .transition(.opacity)
            }
            HStack {
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.headline)
                    Text(character.nickname)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(character.name)
        .onAppear {
            imageLoader.loadImage(from: character.img)
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let ww = Character(charId: 1,
                           name: "Walter White",
                           birthday: "09-07-1958",
                           occupation: ["High School Chemistry Teacher", "Meth King Pin"],
                           img: URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!,
                           status: "Presumed dead",
                           nickname: "Heisenberg",
                           appearance: [1, 2, 3, 4, 5],
                           portrayed: "Bryan Cranston",
                           category: "Breaking Bad",
                           betterCallSaulAppearance: [])
        CharacterDetailView(character: ww)
    }
}
