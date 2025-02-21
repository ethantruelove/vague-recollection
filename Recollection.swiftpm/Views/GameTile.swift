import SwiftUI

struct GameTile: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color)
                    .frame(height: 150)
                    .shadow(radius: 10)
                
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(10)
        }
    }
}

