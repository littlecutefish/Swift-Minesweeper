//
//  MinesweeperApp.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/3.
//

import SwiftUI

@main
struct MinesweeperApp: App {
    var gameSettings = GameSettings()
    
    var body: some Scene {
        WindowGroup {
            ConfigView()
        }
    }
}
