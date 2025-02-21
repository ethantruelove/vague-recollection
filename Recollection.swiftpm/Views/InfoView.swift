import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Welcome to Recollection! This is an assortment of memory games made to be short, fun ways to help strengthen your short-term memory.")
            .multilineTextAlignment(.center)
            .padding()
        Button("Close") {
            dismiss()
        }
        .foregroundColor(.blue)
    }
}
