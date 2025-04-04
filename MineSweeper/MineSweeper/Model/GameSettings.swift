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
        // Calculate the size of each cell
        // but make sure it is not smaller than the minimum size
        let minSize: CGFloat = 30 // Minimum cell size
        let screenWidth = UIScreen.main.bounds.width
        
        // Calculate the cell size based on the screen width
        // and number of columns, but not less than the minimum size
        return max(minSize, screenWidth / CGFloat(numberOfColumns) - 2) // -2 : leave space for the border
    }
}
