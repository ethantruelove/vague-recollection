import SwiftUI

func quitButton(action: @escaping () -> Void) -> some View {
    return Button("Quit") { action() }
        .foregroundColor(.white)
        .padding()
        .background(Color.red)
        .cornerRadius(8)
}
