import SwiftUI

/// Main page of the app.
struct StopsPage: View {
    @State var apiResult: StopsApiResult? = nil
    
    @State var error: ApiError? = nil
    @State var showError = false

    @State var showTutorial = false
    
    @State var isSearchActive = false
    @State var searchQuery = ""
    
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-programmatic-navigation-in-swiftui
    @State var selectedStop = Stop.empty
    @State var navigateToSelectedStop = false
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView()
            } else {
                GeometryReader { geo in
                    List {
                        if !isSearchActive && searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            // Header
                            Section {
                                // Featured stops
                                FeaturedStops(
                                    stops: apiResult!.featured!,
                                    forceTwoColumns: geo.size.width < 350,
                                    onStopSelected: { stop in
                                        selectedStop = stop
                                        navigateToSelectedStop = true
                                    }
                                )
                            }
                            
                            // Stops list title + hidden link
                            Section {
                                // Hidden navigation link for programmatic navigation
                                ZStack(alignment: .bottomLeading) {
                                    NavigationLink(destination: StopPage(stop: selectedStop), isActive: $navigateToSelectedStop) {
                                        EmptyView()
                                    }
                                    .disabled(!navigateToSelectedStop)
                                    .allowsHitTesting(false)
                                    .opacity(0)
                                    
                                    Text("Tous les arrêts")
                                    .font(.system(
                                        size: UIFont.preferredFont(forTextStyle: .title3).pointSize,
                                        weight: .semibold,
                                        design: .default
                                    ))
                                    .padding(.bottom, -8)
                                }
                            }
                        }
                        
                        Section {
                            // Search bar
                            SearchBar(value: $searchQuery, isActive: $isSearchActive, placeholder: "Rechercher un arrêt")
                                .listRowInsets(EdgeInsets())
                                .buttonStyle(PlainButtonStyle()) // fixes the behavior of buttons, https://stackoverflow.com/a/58368388/4652564
                                .padding(.horizontal)
                        }
                        
                        // Stops list
                        Section {
                            let stops = filteredStops
                            
                            ForEach(stops) { stop in
                                NavigationLink(destination: StopPage(stop: stop), label: {
                                    MultiLevelText(source: stop.name.formatted)
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
        Stop(
            id: "BAIR",
            name: Stop.Name(formatted: "Bel-Air", corrected: "Bel-Air", raw: "Bel-Air"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "CVIN",
            name: Stop.Name(formatted: "Gare Cornavin", corrected: "Gare Cornavin", raw: "Gare Cornavin"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "RIVE",
            name: Stop.Name(formatted: "Rive", corrected: "Rive", raw: "Rive"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "MONT",
            name: Stop.Name(formatted: "Annemasse<small>-Parc Montessuit</small>", corrected: "Annemasse-Parc Montessuit", raw: "Parc montessuit"),
            lines: [],
            geolocation: nil
        ),
    ]
    
    static let apiResult = StopsApiResult(
        error: nil,
        featured: Array(sampleStops[0...2]),
        all: sampleStops
    )
    
    static var previews: some View {
        StopsPage(apiResult: apiResult)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
        
        StopsPage(apiResult: apiResult)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        
        StopsPage(apiResult: apiResult)
        
        StopsPage(apiResult: apiResult)
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
    }
}
