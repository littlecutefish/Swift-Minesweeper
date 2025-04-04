# Swift Minesweeper

A classic Minesweeper game built with SwiftUI, featuring customizable board sizes and difficulty levels.

## Features

- **Multiple Difficulty Levels**:
  - Beginner: 9×9 board with 10 mines
  - Intermediate: 16×16 board with 40 mines
  - Expert: 30×16 board with 99 mines
  
- **Custom Game Configuration**:
  - Adjustable rows (5-20)
  - Adjustable columns (5-20)
  - Customizable mine count
  
- **Game Features**:
  - Safe first click (first click never hits a mine)
  - Flag cells with long press
  - Auto-revealing adjacent empty cells
  - Game progress tracking
  - Win/lose detection
  
- **User Interface**:
  - Scrollable game board for larger configurations
  - Progress indicator
  - Remaining mines counter
  - Cell borders for better visibility

## How to Play

1. **Start Screen**:
   - Choose a predefined difficulty (Beginner, Intermediate, Expert), or
   - Create a custom game by adjusting rows, columns, and mine count

2. **Game Controls**:
   - **Tap** a cell to reveal it
   - **Long press** a cell to flag/unflag it as a potential mine
   - Use the **New Game** button to restart

3. **Game Objective**:
   - Reveal all safe cells without detonating any mines
   - Use number clues to determine mine locations
   - Flag mines to keep track of identified dangers

## Implementation Details

The game is built with SwiftUI and follows the MVVM architecture:

- **Models**:
  - `Cell`: Represents a single cell with properties for status, position, etc.
  - `Game`: Manages game state, logic, and board generation
  - `GameSettings`: Stores configuration parameters

- **Views**:
  - `ConfigView`: Initial configuration screen with difficulty options
  - `BoardView`: Main game board with scrollable interface
  - `CellView`: Individual cell UI component
  - `GameStatusView`: Shows game progress and remaining flags

## Technical Highlights

- **Responsive Design**: Automatically adapts to different screen sizes
- **Scrollable Interface**: Handles large board configurations elegantly
- **Safe First Click**: Implements standard Minesweeper behavior
- **Optimized Cell Rendering**: Efficient display of the game grid
- **State Management**: Using SwiftUI's state management capabilities

## Future Enhancements

Potential improvements for future versions:
- Game timer
- High score system
- Dark mode support
- Haptic feedback
- Save/resume functionality
- Customizable themes
