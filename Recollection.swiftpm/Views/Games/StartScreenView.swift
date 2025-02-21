import SwiftUI

struct StartScreenView: View {
    let gameName: String
    let description: String
    let onStart: () -> Void
    
    var body: some View {
        VStack {
            Text(gameName)
                .font(.largeTitle)
                .bold()
            
            Text(description)
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Button(action: onStart) {
                Text("Start")
                    .font(.title)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top)
        }
    }
}
