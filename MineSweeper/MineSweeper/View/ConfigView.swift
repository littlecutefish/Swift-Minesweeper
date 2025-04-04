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
    
    // Range
    private let rowRange = 5...30
    private let columnRange = 5...20
    private let bombPercentageRange = 10...30
    
    // Calculate max of bombs' count
    private var maxBombs: Int {
        return (gameSettings.numberOfRows * gameSettings.numberOfColumns) / 3
    }
    
    // Button for choosing three different level
    private func difficultyButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.macaron.deepLavender)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    Image(systemName: "grid.circle")
                        .font(.system(size: 60))
                        .foregroundColor(Color.macaron.deepRose)
                    Text("~ Minesweeper ~")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding()
                
                Spacer()
                
                // Level choosing
                HStack(spacing: 12) {
                    difficultyButton(title: "Beginner", action: {
                        gameSettings.numberOfRows = 9
                        gameSettings.numberOfColumns = 9
                        gameSettings.numberOfBombs = 10
                    })
                    
                    difficultyButton(title: "Intermediate", action: {
                        gameSettings.numberOfRows = 16
                        gameSettings.numberOfColumns = 16
                        gameSettings.numberOfBombs = 40
                    })
                    
                    difficultyButton(title: "Advanced", action: {
                        gameSettings.numberOfRows = 30
                        gameSettings.numberOfColumns = 16
                        gameSettings.numberOfBombs = 99
                    })
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.vertical, 10)
                
                VStack(alignment: .leading, spacing: 25) {
                    Text("Custom Settings")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    // Row setting
                    VStack(alignment: .leading) {
                        Text("Rows: \(gameSettings.numberOfRows)")
                            .font(.subheadline)
                        
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
                    
                    // Column setting
                    VStack(alignment: .leading) {
                        Text("Columns: \(gameSettings.numberOfColumns)")
                            .font(.subheadline)
                        
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
                    
                    // Bombs setting
                    VStack(alignment: .leading) {
                        Text("Bomb's Count: \(gameSettings.numberOfBombs)")
                            .font(.subheadline)
                        
                        HStack {
                            Text("1")
                            Slider(value: Binding(
                                get: { Double(gameSettings.numberOfBombs) },
                                set: { gameSettings.numberOfBombs = Int($0) }
                            ), in: 1...Double(maxBombs), step: 1)
                            Text("\(maxBombs)")
                        }
                        
                        Text("Bomb Density: \(bombPercentage)%")
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
                            // Reset the game
                            gameSettings.objectWillChange.send()
                        }
                ) {
                    Text("Start Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.macaron.deepSkyBlue)
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
