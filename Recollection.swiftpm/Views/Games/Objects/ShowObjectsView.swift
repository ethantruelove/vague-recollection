import SwiftUI

struct ShowObjectsView: View {
    let objectsToRemember: [String]
    let onComplete: () -> Void
    
    var body: some View {
        VStack {
            Text("Remember these:")
                .font(.headline)
                .padding()
            
            HStack(spacing: 20) {
                ForEach(objectsToRemember, id: \.self) { object in
                    Text(object)
                        .font(.system(size: 40))
                }
            }
            .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(max(2, objectsToRemember.count))) {
                onComplete()
            }
        }
    }
}
