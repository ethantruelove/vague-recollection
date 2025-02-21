import SwiftUI

struct SequenceInputView: View {
    let sequence: [Int]
    let onSuccess: () -> Void
    let onFailure: () -> Void
    
    @State private var userInput: [Int] = []
    
    var body: some View {
        VStack {
            Text("Enter the Sequence")
                .font(.title2)
                .padding(.bottom, 10)
            
            Text("\(userInput.map { String($0) }.joined())")
                .font(.title)
                .padding(5)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(1...9, id: \.self) { number in
                    sequenceButton(action: handleInput, number: number)
                }
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                sequenceButton(action: handleInput, number: 0)
            }
        }
    }
    
    func sequenceButton(action: @escaping (Int) -> Void, number: Int) -> some View {
        Button(action: { action(number) }) {
            Text("\(number)")
                .font(.largeTitle)
                .frame(width: 70, height: 70)
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
    
    private func handleInput(_ number: Int) {
        guard !sequence.isEmpty else { return }
        if number == sequence[userInput.count] {
            userInput.append(number)
            if userInput.count == sequence.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    onSuccess()
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                onFailure()
            }
        }
    }
}
