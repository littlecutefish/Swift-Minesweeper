//
//  Game.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import Foundation

class Game: ObservableObject {
    /// The game settings
    @Published var settings: GameSettings
    
    init(from settings: GameSettings) {
        self.settings = settings
    }
}
