//
//  ConfigView.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/4.
//

import SwiftUI

struct ConfigView: View {
    @StateObject private var gameSettings = GameSettings()
    @State private var isGameStarted = false
    
    // Sliders ranges
    private let rowRange = 5...20
    private let columnRange = 5...20
    private let bombPercentageRange = 10...30
    
    // Computed property to calculate max bombs based on board size
    private var maxBombs: Int {
        return (gameSettings.numberOfRows * gameSettings.numberOfColumns) / 3
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Minesweeper")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 25) {
                    // Rows configuration
                    VStack(alignment: .leading) {
                        Text("Rows: \(gameSettings.numberOfRows)")
                            .font(.headline)
                        
                        HStack {
                            Text("\(rowRange.lowerBound)")
                            Slider(value: Binding(
                                get: { Double(gameSettings.numberOfRows) },
                                set: { gameSettings.numberOfRows = Int($0) }
                            ), in: Double(rowRange.lowerBound)...Double(rowRange.upperBound), step: 1)
                            Text("\(rowRange.upperBound)")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Columns configuration
                    VStack(alignment: .leading) {
                        Text("Columns: \(gameSettings.numberOfColumns)")
                            .font(.headline)
                        
                        HStack {
                            Text("\(columnRange.lowerBound)")
                            Slider(value: Binding(
                                get: { Double(gameSettings.numberOfColumns) },
                                set: { gameSettings.numberOfColumns = Int($0) }
                            ), in: Double(columnRange.lowerBound)...Double(columnRange.upperBound), step: 1)
                            Text("\(columnRange.upperBound)")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Bombs configuration
                    VStack(alignment: .leading) {
                        Text("Bombs: \(gameSettings.numberOfBombs)")
                            .font(.headline)
                        
                        HStack {
                            Text("1")
                            Slider(value: Binding(
                                get: { Double(gameSettings.numberOfBombs) },
                                set: { gameSettings.numberOfBombs = Int($0) }
                            ), in: 1...Double(maxBombs), step: 1)
                            Text("\(maxBombs)")
                        }
                        
                        Text("Bomb density: \(bombPercentage)%")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                .padding()
                
                Spacer()
                
                NavigationLink(destination:
                    BoardView()
                        .environmentObject(Game(from: gameSettings))
                        .navigationBarBackButtonHidden(true)
                        .onDisappear {
                            // Reset game settings for next game
                            gameSettings.objectWillChange.send()
                        }
                ) {
                    Text("Start Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
        }
    }
    
    // Calculate bomb percentage
    private var bombPercentage: Int {
        let totalCells = gameSettings.numberOfRows * gameSettings.numberOfColumns
        return Int((Double(gameSettings.numberOfBombs) / Double(totalCells)) * 100)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
