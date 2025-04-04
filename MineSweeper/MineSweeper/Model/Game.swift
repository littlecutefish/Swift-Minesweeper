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
    
    /// Current game state
    @Published var gameState: GameState = .playing
    
    /// Game state enum
    enum GameState {
        case playing
        case won
        case lost
    }
    
    init(from settings: GameSettings) {
        self.settings = settings
        self.board = Self.generateBoard(from: settings) // Construct the board; Self=call the type of "Game"
        self.isFirstClick = true
        self.gameState = .playing
    }
    
    // Reset the game to start a new one with the same settings
    func resetGame() {
        self.board = Self.generateBoard(from: settings)
        self.isFirstClick = true
        self.gameState = .playing
        self.objectWillChange.send()
    }
    
    // Track first click
    private var isFirstClick = true
    
    // MARK: - Public Function
    func click(on cell: Cell) {
        // If game is over, do nothing
        guard gameState == .playing else { return }
        
        // If cell is flagged, do nothing
        guard !cell.isFlagged else { return }
        
        // Handle first click - ensure it's not a bomb
        if isFirstClick {
            isFirstClick = false
            
            // If first click is a bomb, move it elsewhere
            if cell.status == .bomb {
                relocateBomb(from: cell)
            }
            
            // Ensure no bombs in neighboring cells on first click (for better player experience)
            let neighbors = getNeighborCells(for: cell)
            for neighbor in neighbors {
                if neighbor.status == .bomb {
                    relocateBomb(from: neighbor)
                }
            }
        }
        
        // Check we didn't click on a bomb
        if cell.status == .bomb {
            cell.isOpened = true
            gameState = .lost
            revealAllBombs()
        } else {
            reveal(for: cell)
            checkWinCondition()
        }
        
        // Tell UI we have published some changes
        self.objectWillChange.send()
    }
    
    // Relocate a bomb to a safe location
    private func relocateBomb(from cell: Cell) {
        // First set the cell's status to normal
        cell.status = .normal
        
        // Find a new location for the bomb
        var relocated = false
        while !relocated {
            let randomRow = Int.random(in: 0..<board.count)
            let randomCol = Int.random(in: 0..<board[0].count)
            let targetCell = board[randomRow][randomCol]
            
            // Only relocate to unopened cells that don't already have bombs
            if !targetCell.isOpened && targetCell.status != .bomb {
                targetCell.status = .bomb
                relocated = true
            }
        }
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
        let maxCol = min(col + 1, board[0].count - 1) // Fix here - use board[0].count
        
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
            // Get all neighboring cells
            let neighbors = getNeighborCells(for: cell)
            
            // Reveal empty neighbor cells
            for neighborCell in neighbors {
                reveal(for: neighborCell)
            }
        }
    }
    
    // Helper method to get all neighboring cells
    private func getNeighborCells(for cell: Cell) -> [Cell] {
        let row = cell.row
        let col = cell.column
        
        let minRow = max(row - 1, 0)
        let minCol = max(col - 1, 0)
        let maxRow = min(row + 1, board.count - 1)
        let maxCol = min(col + 1, board[0].count - 1)
        
        var neighbors = [Cell]()
        
        for r in minRow...maxRow {
            for c in minCol...maxCol {
                // Skip the cell itself
                if r == row && c == col {
                    continue
                }
                neighbors.append(board[r][c])
            }
        }
        
        return neighbors
    }
    
    // Reveal all bombs when game is over
    private func revealAllBombs() {
        for row in 0..<board.count {
            for col in 0..<board[row].count {
                if board[row][col].status == .bomb {
                    board[row][col].isOpened = true
                }
            }
        }
    }
    
    // Check if player has won
    private func checkWinCondition() {
        let totalCells = settings.numberOfRows * settings.numberOfColumns
        let bombCount = settings.numberOfBombs
        var openedCount = 0
        
        for row in 0..<board.count {
            for col in 0..<board[row].count {
                if board[row][col].isOpened {
                    openedCount += 1
                }
            }
        }
        
        // Player wins if all non-bomb cells are opened
        if openedCount == totalCells - bombCount {
            gameState = .won
        }
    }
}
