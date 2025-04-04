# Swift Minesweeper

A classic Minesweeper game built with SwiftUI.

## Features

- Customizable game board size (rows and columns)
- Adjustable number of bombs
- Flag cells with long press
- Auto-revealing of adjacent empty cells
- Game status tracking (win/lose conditions)
- Progress indicator

## How to Play

1. **Start Screen**: Configure your game by adjusting:
   - Number of rows (5-20)
   - Number of columns (5-20)
   - Number of bombs (1-⅓ of total cells)

2. **Game Controls**:
   - **Tap** a cell to reveal it
   - **Long press** a cell to flag/unflag it as a potential bomb
   - Use the **New Game** button to return to configuration screen

3. **Game Objective**:
   - Reveal all non-bomb cells without detonating any bombs
   - Use number clues to determine where bombs are located
   - Flag all bombs to help track their locations

## Implementation Details

The game is implemented using the following structure:

- **Models**:
  - `Cell`: Represents a single cell on the board
  - `Game`: Manages game state and logic
  - `GameSettings`: Stores configuration for the game

- **Views**:
  - `ConfigView`: Initial screen for game configuration
  - `BoardView`: Main game board display
  - `CellView`: Individual cell rendering
  - `GameStatusView`: Displays game progress and remaining flags

## Future Enhancements

Possible future improvements:
- Timer tracking
- High score system
- Custom difficulty presets
- Themes/visual customization
- Sound effects

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+
