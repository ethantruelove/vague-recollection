import SwiftUI

struct HomeView: View {
    @State private var selectedGame: String? = nil
    @State private var showingInfo: Bool = false
    
    var body: some View {
        if let game = selectedGame {
            launchGame(for: game)
        }
        else {
            VStack {
                Text("Recollection")
                    .font(.system(size: 70))
                    .bold()
                
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    GameTile(title: "Sequence", color: .red) { selectedGame = "Sequence" }
                    GameTile(title: "Collections", color: .green) { selectedGame = "Objects" }
                    GameTile(title: "Matching Pairs", color: .blue) { selectedGame = "Grid" }
                }
                
                // TODO: Add info and statistics functionality
                HStack {
                    Spacer()
                    Button(action: {
                        showingInfo = true
                    }) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $showingInfo) {
                        InfoView()
                    }
                    Spacer()
                }
                .padding(10)
            }
        }
    }
    
    @ViewBuilder
    private func launchGame(for game: String) -> some View {
        switch game {
        case "Sequence": SequenceView { selectedGame = nil }
        case "Objects": ObjectsView { selectedGame = nil }
        case "Grid": GridView { selectedGame = nil }
        default: ContentView()
        }
    }
}

