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
    
    /// The game board
    @Published var board: [[Cell]]
    
    init(from settings: GameSettings) {
        self.settings = settings
        self.board = Self.generateBoard(from: settings) // Construct the board; Self=call the type of "Game"
    }
    
    /// Generate the board with the given number of boms
    /// - Parameter settings: The game settings to create the board from
    /// - Returns: 2D array of cells from which the starting game will be played
    private static func generateBoard(from settings: GameSettings) -> [[Cell]] {
        var newBoard = [[Cell]]()

        for row in 0..<settings.numberOfRows {
            var column = [Cell]()

            for col in 0..<settings.numberOfColumns {
                column.append(Cell(row: row, column: col))
            }

            newBoard.append(column)
        }
        
        // Place our bombs until they've all been placed
        var numberOfBombsPlaced = 0
        while numberOfBombsPlaced < settings.numberOfBombs {
            // Generate a random number that will fall somewhere in our board
            let randomRow = Int.random(in: 0..<settings.numberOfRows)
            let randomCol = Int.random(in: 0..<settings.numberOfColumns)

            let currentRandomCellStatus = newBoard[randomRow][randomCol].status
            if currentRandomCellStatus != .bomb {
                newBoard[randomRow][randomCol].status = .bomb
                numberOfBombsPlaced += 1
            }
        }

        return newBoard
    }
}


