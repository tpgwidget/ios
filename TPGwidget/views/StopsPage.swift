import SwiftUI

/// Main page of the app.
struct StopsPage: View {
    @State var apiResult: StopsApiResult? = nil
    
    @State var error: ApiError? = nil
    @State var showError = false

    @State var showTutorial = false
    
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView()
            } else {
                List {
                    Section {
                        SearchBar(value: $searchQuery, placeholder: "Rechercher un arrêt")
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .buttonStyle(PlainButtonStyle()) // fixes the behavior of buttons, https://stackoverflow.com/a/58368388/4652564
                    }
                    
                    Section {
                        let stops = filteredStops
                        
                        ForEach(stops) { stop in
                            NavigationLink(destination: StopPage(stop: stop), label: {
                                MultiLevelText(source: stop.nameFormatted)
                            })
                        }
                        
                        if stops.isEmpty {
                            Text("Aucun arrêt trouvé.").italic()
                        }
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
        .alert(isPresented: $showError, content: {
            Alert(
                title: Text(error!.formattedTitle),
                message: Text(error!.formattedContent),
                dismissButton: .default(Text("Réessayer"), action: load)
            )
        })
        
        // Tutorial
        .sheet(isPresented: $showTutorial, content: {
            TutorialPage()
        })
    }
    
    var isLoading: Bool { apiResult == nil }
    
    var filteredStops: [Stop] {
        let query = Stop.normalizeForSearch(searchQuery)
        if query.isEmpty {
            return apiResult!.all!
        }
        
        return apiResult!.all!.filter { $0.nameMatches(query) }
    }
    
    /// Loads the view’s contents from the API.
    func load() {
        if apiResult != nil {
            return
        }
        
        StopsApiResult.fetch(
            success: { stops in
                self.apiResult = stops
                self.showTutorial = true
            },
            error: { error in
                self.error = error
                self.showError = true
            }
        )
    }
}

struct StopsPage_Previews: PreviewProvider {
    static let sampleStops = [
        Stop(id: "BAIR", nameFormatted: "Bel-Air", nameRaw: "Bel-Air", lines: [], geolocation: nil),
        Stop(id: "CVIN", nameFormatted: "Gare Cornavin", nameRaw: "Gare Cornavin", lines: [], geolocation: nil),
        Stop(id: "RIVE", nameFormatted: "Rive", nameRaw: "Rive", lines: [], geolocation: nil),
        Stop(id: "MONT", nameFormatted: "Annemasse<small>-Parc Montessuit</small>", nameRaw: "Annemasse-Parc", lines: [], geolocation: nil),
    ]
    
    static var previews: some View {
        StopsPage(apiResult:
            StopsApiResult(
                error: nil,
                featured: sampleStops,
                all: sampleStops
            )
        )
    }
}
