import SwiftUI

struct CountdownView: View {
    @State private var countdown: Int = 3
    
    let onComplete: () -> Void
    
    var body: some View {
        Text("\(countdown)")
            .font(.system(size: 80, weight: .bold))
            .transition(.scale)
            .onAppear {
                runCountdown()
            }
    }
    
    private func runCountdown() {
        if countdown > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                countdown -= 1
                runCountdown()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                onComplete()
            }
        }
    }
}
