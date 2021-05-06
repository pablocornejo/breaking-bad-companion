//
//  Character.swift
//  BreakingBadCompanion
//
//  Created by Pablo Cornejo on 2/27/21.
//

import Foundation

struct Character: Codable {
    let charId: Int
    let name, birthday: String
    let occupation: [String]
    let img: URL
    let status, nickname: String
    let appearance: [Int]
    let portrayed, category: String
    let betterCallSaulAppearance: [Int]
}

extension Character: Identifiable {
    var id: Int { charId }
}
