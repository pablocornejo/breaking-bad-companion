//
//  BreakingBadCompanionApp.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import SwiftUI

@main
struct BreakingBadCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersListView(viewModel: .init())
        }
    }
}
