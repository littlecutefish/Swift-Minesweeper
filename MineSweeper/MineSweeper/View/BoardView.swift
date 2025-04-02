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
            ForEach(0..<game.settings.numberOfRows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<game.settings.numberOfColumns,id: \.self) { col in
                        CellView(cell: Cell(row: row, column: col))
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
