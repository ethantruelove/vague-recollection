import SwiftUI

struct ShowGridView: View {
    let pairCount: Int
    let objects: [String]
    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            Text("Remember these:")
                .font(.headline)
                .padding()
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: Int(ceil(sqrt(Double(pairCount)))))
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<(pairCount * 2), id: \.self) { index in
                    Text(objects[index])
                        .font(.system(size: 30))
                        .frame(width: 50, height: 50)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(max(2, pairCount / 2))) {
                onComplete()
            }
        }
    }
}
