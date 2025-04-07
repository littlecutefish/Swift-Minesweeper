//
//  CellView.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import SwiftUI

struct CellView: View {
    
    @EnvironmentObject var game: Game
    let cell: Cell
    
    var body: some View {
        cell.image
            .scaledToFill()
            .frame(width: game.settings.squareSize,
                   height: game.settings.squareSize,
                   alignment: .center)
            .border(Color.macaron.cellBorder, width: 0.5)
            .onTapGesture {
                game.click(on: cell)
            }
            .onLongPressGesture {
                // Flag the cell on long press
                if !cell.isOpened {
                    cell.isFlagged.toggle()
                    game.objectWillChange.send()
                }
            }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(cell: Cell(row: 0, column: 0))
            .environmentObject(Game(from: GameSettings())) // Add env object that CellView can access it
    }
}
