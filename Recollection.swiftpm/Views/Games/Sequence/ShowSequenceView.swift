import SwiftUI

struct ShowSequenceView: View {
    let sequence: [Int]
    let onComplete: () -> Void
    
    @State private var currentIndex: Int = 0
    @State private var isVisible: Bool = false
    
    var body: some View {
        if currentIndex < sequence.count {
            Text("\(sequence[currentIndex])")
                .font(.system(size: 80, weight: .bold))
                .opacity(isVisible ? 1 : 0)
                .animation(.easeInOut(duration: 0.5), value: isVisible)
                .onAppear {
                    showNext()
                }
        }
    }
    private func showNext() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                isVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    isVisible = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if currentIndex < sequence.count - 1 {
                        currentIndex += 1
                        showNext()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            onComplete()
                        }
                    }
                }
            }
        }
    }
}
