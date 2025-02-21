import SwiftUI

struct ObjectsView: View {
    let onBack: () -> Void
    
    @State private var score: Int = 0
    @State private var gameState: ObjectsState = .startScreen
    @State private var objectsToRemember: [String] = []
    @State private var availableObjects: [String] = []
    
    private let allObjects = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯",
                              "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆",
                              "🦉", "🦇", "🐺", "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌"]
    
    func startGame() {
        score = 0
        availableObjects = allObjects.shuffled()
        prepareNextRound()
    }
    
    func prepareNextRound() {
        objectsToRemember = Array(availableObjects.prefix(score + 1))
        gameState = .showingObjects
    }
    
    var body: some View {
        VStack {
            if gameState == .startScreen {
                StartScreenView(
                    gameName: "Collections",
                    description: "Memorize the objects and pick them out from a collection in any order",
                    onStart: {
                        startGame()
                    }
                )
            } else if gameState == .showingObjects {
                ShowObjectsView(
                    objectsToRemember: objectsToRemember,
                    onComplete: { gameState = .inputPhase }
                )
            } else if gameState == .inputPhase {
                ObjectsInputView(
                    objectsToRemember: objectsToRemember,
                    objects: allObjects.shuffled(),
                    onSuccess: {
                        score += 1
                        prepareNextRound()
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
        else if gameState != .showingObjects {
            quitButton { onBack() }
        }
    }
}
