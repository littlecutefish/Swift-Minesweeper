//
//  BoardView.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var game: Game
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<game.board.count, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<game.board[row].count,id: \.self) { col in
                        CellView(cell: game.board[row][col])
                    }
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    private static var gameSetting = GameSettings()
    static var previews: some View {
        BoardView().environmentObject(Game(from: gameSetting))
    }
    
}
