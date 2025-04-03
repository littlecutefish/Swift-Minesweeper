//
//  GameSettings.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject{
    /// The number of rows on the board
    @Published var numberOfRows = 10
    
    /// The number of columns on the board
    @Published var numberOfColumns = 10
    
    /// The total number of bombs
    @Published var numberOfBombs = 10
    
    /// The size each square should be based on the width of the screen
    var squareSize: CGFloat {
        UIScreen.main.bounds.width / CGFloat(numberOfColumns)
    }
}

