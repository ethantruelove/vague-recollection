import SwiftUI

struct SequenceView: View {
    let onBack: () -> Void
    
    @State private var gameState: SequenceState = .startScreen
    @State private var currentSequence: [Int] = []
    @State private var score: Int = 0
    @State private var showResult: Bool = false
    
    func startGame() {
        score = 0
        currentSequence = [Int.random(in: 0...9)]
        gameState = .showingSequence
    }
    
    var body: some View {
        VStack {
            if gameState == .startScreen {
                StartScreenView(
                    gameName: "Sequence",
                    description: "Memorize the growing number sequence in order",
                    onStart: { 
                        startGame()
                    }
                )
            } else if gameState == .showingSequence {
                ShowSequenceView(
                    sequence: currentSequence,
                    onComplete: { gameState = .inputPhase }
                )
            } else if gameState == .inputPhase {
                SequenceInputView(
                    sequence: currentSequence,
                    onSuccess: {
                        score += 1
                        currentSequence.append(Int.random(in: 0...9))
                        gameState = .showingSequence
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
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
        else if gameState != .showingSequence {
            quitButton { onBack() }
        }
    }
}

