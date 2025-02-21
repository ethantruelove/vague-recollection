import SwiftUI

struct ResultView: View {
    @Binding var score: Int
    let onRestart: () -> Void
    
    @State private var isNewHighScore = false
    
    var body: some View {
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("Your Score: \(score)")
                .font(.title2)
                .padding()
            
            Button("Play Again") {
                onRestart()
            }
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 20)
        }
    }
}
