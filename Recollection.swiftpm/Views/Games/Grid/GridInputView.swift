import SwiftUI

struct GridInputView: View {
    let pairCount: Int
    let objects: [String]
    let onSuccess: () -> Void
    let onFailure: () -> Void
    
    @State private var clearedPositions: [Int] = []
    @State private var selectedPositions: [Int] = []
    @State private var failure: Bool = false
    @State private var remainingPairCount: Int
    
    init(pairCount: Int,
         objects: [String],
         onSuccess: @escaping () -> Void,
         onFailure: @escaping () -> Void) {
        self.pairCount = pairCount
        self.objects = objects
        self.onSuccess = onSuccess
        self.onFailure = onFailure
        
        self._remainingPairCount = State(initialValue: pairCount)
    }
    
    var body: some View {
        VStack {
            Text("Find the matching pairs")
                .font(.headline)
                .padding()
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: Int(ceil(sqrt(Double(pairCount)))))
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<(pairCount * 2), id: \.self) { index in
                    if clearedPositions.contains(index) {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 50, height: 50)
                    } else {
                        Button(action: {
                            handleSelection(at: index)
                        }) {
                            Text(selectedPositions.contains(index) ? objects[index] : "")
                                .font(.system(size: 30))
                                .frame(width: 50, height: 50)
                                .background(failure ? 
                                            (selectedPositions.contains(index) ? Color.red : Color.blue.opacity(0.2))
                                            : (Color.blue.opacity(selectedPositions.contains(index) ? 0.8 : 0.2)))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            
            Text("\(remainingPairCount) remaining!")
        }
        .onChange(of: objects) { 
            selectedPositions = []
            clearedPositions = []
        }
    }
    
    private func handleSelection(at position: Int) {
        if selectedPositions.count < 2 {
            selectedPositions.append(position)
            
            if selectedPositions.count == 2 {
                if selectedPositions.count > 1 && objects[selectedPositions[0]] == objects[selectedPositions[1]] {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        clearedPositions.append(selectedPositions[0])
                        clearedPositions.append(selectedPositions[1])
                        selectedPositions.removeFirst(2)
                        remainingPairCount -= 1
                        
                        if remainingPairCount == 0 {
                            onSuccess()
                        }
                        
                    } 
                }else if selectedPositions.count > 1 {
                    failure = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        onFailure()
                    }
                }
            }
        }
    }
}
