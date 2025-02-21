import SwiftUI

struct ObjectsInputView: View {
    let objectsToRemember: [String]
    let objects: [String]
    let onSuccess: () -> Void
    let onFailure: () -> Void
    
    @State private var clearedPositions: [Int] = []
    @State private var remainingObjects: [String]
    
    init(objectsToRemember: [String],
         objects: [String],
         onSuccess: @escaping () -> Void,
         onFailure: @escaping () -> Void) {
        self.objectsToRemember = objectsToRemember
        self.objects = objects
        self.onSuccess = onSuccess
        self.onFailure = onFailure
        
        self._remainingObjects = State(initialValue: objectsToRemember)
    }
    
    var body: some View {
        VStack {
            Text("Find the objects you saw")
                .font(.headline)
                .padding()
            
            let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 5)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<objects.count, id: \.self) { index in
                    if clearedPositions.contains(index) {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 50, height: 50)
                    } else {
                        Button(action: {
                            handleSelection(of: objects[index], at: index)
                        }) {
                            Text(objects[index])
                                .font(.system(size: 30))
                                .frame(width: 50, height: 50)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            
            Text("Find \(remainingObjects.count) more")
                .padding()
        }
        .onChange(of: objectsToRemember) { 
            clearedPositions = []
            remainingObjects = objectsToRemember
        }
    }
    
    private func handleSelection(of object: String, at position: Int) {
        if remainingObjects.contains(object) {
            if let index = remainingObjects.firstIndex(of: object) {
                remainingObjects.remove(at: index)
            }
            clearedPositions.append(position)
            
            if remainingObjects.isEmpty {
                onSuccess()
            }
        } else {
            onFailure()
        }
    }
}
