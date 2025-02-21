import SwiftUI

struct GridView: View {
    let onBack: () -> Void
    
    @State private var score: Int = 0
    @State private var pairCount: Int = 2
    @State private var gameState: GridState = .startScreen
    @State private var toPick: [String] = []
    
    private let allObjects = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯",
                              "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆",
                              "🦉", "🦇", "🐺", "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌"]
    
    func startGame() {
        score = 0
        pairCount = 2
        toPick = Array(allObjects.shuffled().prefix(pairCount))
        toPick = toPick + toPick
        toPick = toPick.shuffled()
        gameState = .showGrid
    }
    
    func nextRound() {
        score += 1
        pairCount += 1
        toPick = Array(allObjects.shuffled().prefix(pairCount))
        toPick = toPick + toPick
        toPick = toPick.shuffled()
        gameState = .showGrid
    }
    
    
    var body: some View {
        VStack {
            if gameState == .startScreen {
                StartScreenView(
                    gameName: "Matching Pairs",
                    description: "Memorize the objects and pick the matching pairs in any order",
                    onStart: {
                        startGame()
                    }
                )
            } else if gameState == .showGrid {
                ShowGridView(
                    pairCount: pairCount,
                    objects: toPick,
                    onComplete: { gameState = .inputPhase }
                )
            } else if gameState == .inputPhase {
                GridInputView(
                    pairCount: pairCount,
                    objects: toPick,
                    onSuccess: {
                        nextRound()
                    },
                    onFailure: {
                        gameState = .result
                    }
                )
            } else if gameState == .result {
                ResultView(
                    score: $score,
                    onRestart: {
                        startGame()
                    }
                )
            }
        }
        .padding()
        
        if gameState == .startScreen {
            Button("Back") { onBack() }
                .foregroundColor(.blue)
        }
        else if gameState != .showGrid {
            quitButton { onBack() }
        }
    }
}
