//
//  Cell.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import Foundation
import SwiftUI

class Cell:ObservableObject {
    /// The row of the cell on the board
    var row: Int
    
    /// The column of the cell on the board
    var column: Int
    
    /// Current state of the cell
    @Published var status: Status
    
    /// Whether or not the cell has been opened or touched
    @Published var isOpened: Bool
    
    /// Whether or not the cell has been flagged
    @Published var isFlagged: Bool
    
    /// Get the image associated to the status of the cell
    var image: some View {
        if !isOpened && isFlagged {
            return AnyView(
                Image(systemName: "flag.fill")
                    .foregroundColor(.red)
                    .background(Color.gray.opacity(0.3))
            )
        }
        
        if !isOpened {
            return AnyView(
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            )
        }
        
        switch status {
        case .bomb:
            return AnyView(
                Image(systemName: "burst.fill")
                    .foregroundColor(.black)
                    .background(Color.red.opacity(0.3))
            )
            
        case .normal:
            return AnyView(
                Rectangle()
                    .fill(Color.macaron.cellBackground.opacity(0.3))
            )
            
        case .exposed(let total):
            if total == 0 {
                return AnyView(
                    Rectangle()
                        .fill(Color.macaron.boardBackground.opacity(0.1))
                )
            }
            
            // Choose color within different number
            let color: Color
            switch total {
            case 1: color = .macaron.number1
            case 2: color = .macaron.number2
            case 3: color = .macaron.number3
            case 4: color = .macaron.number4
            case 5: color = .macaron.number5
            case 6: color = .macaron.number6
            case 7: color = .macaron.number7
            case 8: color = .macaron.softGray
            default: color = .primary
            }
            
            return AnyView(
                ZStack {
                    Text("\(total)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(color)
                }
            )
        }
    }
    
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
        self.status = .normal
        self.isOpened = false
        self.isFlagged = false
    }
}
