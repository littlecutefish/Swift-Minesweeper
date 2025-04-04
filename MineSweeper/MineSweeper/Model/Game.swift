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
    
    // MARK: - Public Function
    func click(on cell: Cell) {
        // Check we didn't click on a bomb
        if cell.status == .bomb {
            cell.isOpened = true
        } else {
            reveal(for: cell)
        }
        
        // Tell UI we have published some changes
        self.objectWillChange.send()
    }
    
    // MARK: - Private Function
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
    
    /// Find the number of the neighbor bombs
    private func getExposedCount(for cell: Cell) -> Int {
        let row = cell.row
        let col = cell.column
        
        let minRow = max(row - 1, 0)
        let minCol = max(col - 1, 0)
        let maxRow = min(row + 1, board.count - 1)
        let maxCol = min(col + 1, board.count - 1)
        
        var totalBombCount = 0
        for row in minRow...maxRow {
            for col in minCol...maxCol {
                if board[row][col].status == .bomb {
                    totalBombCount += 1
                }
            }
        }
        
        return totalBombCount
    }
    
    private func reveal(for cell: Cell) {
        // If the cell is already opened, then skip
        guard !cell.isOpened else {
            return
        }
        
        // If the cell is a flagged, we will not reveal it
        guard !cell.isFlagged else {
            return
        }
        
        // If the cell is bomb, then stop traversing
        guard cell.status != .bomb else {
            return
        }
        
        // Calculate our exposed count
        let exposedCount = getExposedCount(for: cell)
        
        // Set the exposed count on the cell and open it
        cell.status = .exposed(exposedCount)
        cell.isOpened = true
        
        // If it is empty, start traversing the neighboring cells
        // Recurse to visit all the neighbor cells
        if (exposedCount == 0) {
            let topCell = board[max(0, cell.row - 1)][cell.column]
            let bottomCell = board[min(board.count - 1, cell.row + 1)][cell.column]
            let leftCell = board[cell.row][max(0, cell.column - 1)]
            let rightCell = board[cell.row][min(board.count - 1, cell.column + 1)]
            
            // Reveal empty neighbor cells
            reveal(for: topCell)
            reveal(for: bottomCell)
            reveal(for: leftCell)
            reveal(for: rightCell)
        }
    }
}


