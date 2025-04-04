//
//  Cell&statusExtension.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import Foundation

extension Cell {
    /// Denoting the different states a square can be in
    enum Status: Equatable {
        /// The square is open and not touching anything
        case normal
        
        /// The square has been opened and touching n bombs
        /// value = The number of bombs the square is touching, 0 = none
        case exposed(Int)
        
        /// There is a bomb in the square
        case bomb
    }
}
