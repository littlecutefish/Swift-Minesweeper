//
//  BoardView.swift
//  Minesweeper
//
//  Created by 劉俐妤 on 2025/4/2.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var game: Game
    @Environment(\.presentationMode) var presentationMode
    @State private var showingGameOver = false
    @State private var gameWon = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Game information fixed at the top
                VStack(spacing: 10) {
                    // Game info header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Board: \(game.settings.numberOfRows)×\(game.settings.numberOfColumns)")
                                .font(.subheadline)
                            Text("Bombs: \(game.settings.numberOfBombs)")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Reset game state before returning to config screen
                            game.resetGame()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("New Game")
                                .fontWeight(.bold)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Game status view
                    GameStatusView()
                        .padding(.horizontal)
                }
                .padding(.top)
                .background(Color.white)
                .zIndex(1) // Make sure it's always on top
                
                // Scrollable game board area
                ScrollView([.horizontal, .vertical], showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(0..<game.board.count, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<game.board[row].count, id: \.self) { col in
                                    CellView(cell: game.board[row][col])
                                }
                            }
                        }
                    }
                    .padding(5)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(5)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Fixed bottom guidance information
                VStack(alignment: .leading, spacing: 5) {
                    Text("Instructions:")
                        .font(.headline)
                    Text("• Tap to reveal a cell")
                    Text("• Long press to flag/unflag a cell")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.bottom)
                .background(Color.white)
                .zIndex(1) // Make sure it always appears at the bottom
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showingGameOver) {
                Alert(
                    title: Text(gameWon ? "You Won!" : "Game Over"),
                    message: Text(gameWon ? "Congratulations! You found all mines." : "You hit a mine!"),
                    primaryButton: .default(Text("Play Again")) {
                        game.resetGame()
                    },
                    secondaryButton: .cancel(Text("Continue"))
                )
            }
            .onReceive(game.$gameState) { state in
                if state == .won {
                    gameWon = true
                    showingGameOver = true
                } else if state == .lost {
                    gameWon = false
                    showingGameOver = true
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
