import SwiftUI

/// Main page of the app.
struct StopsPage: View {
    @State var stops: StopsAPIResult? = nil
    @State var showErrorMessage = false
    @State var showTutorial = false
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(stops!.all) { stop in
                        NavigationLink(destination: StopPage(stop: stop), label: {
                            Text(stop.nameRaw)
                        })
                    }
                }
                .navigationTitle("Nouveau raccourci")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: { showTutorial = true }, label: {
                            Image(systemName: "questionmark.circle")
                        })
                        .accessibility(label: Text("Tutoriel"))
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: load)
        
        // Loading error alert
        .alert(isPresented: $showErrorMessage, content: {
            Alert(
                title: Text("Connexion impossible"),
                message: Text("TPGwidget n’a pas pu se connecter au serveur. La connexion à Internet fonctionne-t-elle ?"),
                dismissButton: .default(Text("Réessayer"), action: load)
            )
        })
        
        // Tutorial
        .sheet(isPresented: $showTutorial, content: {
            NavigationView {
                TutorialPage()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.white)
        })
    }
    
    var isLoading: Bool { stops == nil }
    
    /// Loads the view’s contents from the API.
    func load() {
        if stops != nil {
            return
        }
        
        StopsAPIResult.fetch(
            success: { stops in
                self.stops = stops
                self.showTutorial = true
            },
            error: {
                self.showErrorMessage = true
            }
        )
    }
}

struct StopsPage_Previews: PreviewProvider {
    static var previews: some View {
        StopsPage(stops: StopsAPIResult(all: [
            Stop(id: "BAIR", nameFormatted: "Bel-Air", nameRaw: "Bel-Air", lines: [], geolocation: nil),
            Stop(id: "CVIN", nameFormatted: "Gare Cornavin", nameRaw: "Gare Cornavin", lines: [], geolocation: nil),
            Stop(id: "RIVE", nameFormatted: "Rive", nameRaw: "Rive", lines: [], geolocation: nil)
        ]))
    }
}
