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
                    .fill(Color.gray.opacity(0.3))
            )
            
        case .exposed(let total):
            if total == 0 {
                return AnyView(
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                )
            }
            
            // 根据数字选择不同的颜色
            let color: Color
            switch total {
            case 1: color = .blue
            case 2: color = .green
            case 3: color = .red
            case 4: color = .purple
            case 5: color = .orange
            case 6: color = .pink
            case 7: color = .black
            case 8: color = .gray
            default: color = .primary
            }
            
            return AnyView(
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
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
