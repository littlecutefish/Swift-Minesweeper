//
//  GameStatusView.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/4.
//

import SwiftUI

struct GameStatusView: View {
    @EnvironmentObject var game: Game
    
    // Count remaining flags (bombs - flagged cells)
    private var remainingFlags: Int {
        var flaggedCount = 0
        
        for row in game.board {
            for cell in row {
                if cell.isFlagged {
                    flaggedCount += 1
                }
            }
        }
        
        return game.settings.numberOfBombs - flaggedCount
    }
    
    // Count revealed cells
    private var revealedCells: Int {
        var revealedCount = 0
        
        for row in game.board {
            for cell in row {
                if cell.isOpened {
                    revealedCount += 1
                }
            }
        }

        return revealedCount
    }
    
    // Calculate percentage of completion
    private var completionPercentage: Int {
        let totalCells = game.settings.numberOfRows * game.settings.numberOfColumns
        let bombCount = game.settings.numberOfBombs
        let safeCells = totalCells - bombCount
        
        guard safeCells > 0 else { return 0 }
        
        return Int((Double(revealedCells) / Double(safeCells)) * 100)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "flag.fill")
                    .foregroundColor(.red)
                Text("\(remainingFlags) remaining")
                    .font(.headline)
                
                Spacer()
                
                Text("Progress: \(completionPercentage)%")
                    .font(.headline)
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(width: min(CGFloat(completionPercentage) * geometry.size.width / 100, geometry.size.width), height: 10)
                        .foregroundColor(Color.macaron.deepSkyBlue)
                }
                .cornerRadius(5)
            }
            .frame(height: 10)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct GameStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusView()
            .environmentObject(Game(from: GameSettings()))
    }
}
