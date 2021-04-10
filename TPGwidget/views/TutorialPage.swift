import SwiftUI

/// Shows the tutorial of the app.
struct TutorialPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selection = 0
    
    let slides = [
        "Bienvenue ! Ce court tutoriel vous expliquera comment fonctionne TPGwidget.",
        "TPGwidget permet de créer sur votre écran d'accueil un raccourci pour votre arrêt de bus ou de tram.",
        "Vous pouvez utiliser n’importe quel arrêt : domicile, travail, école… Et vous pouvez créer autant de raccourcis que vous voulez !",
        "C’est parti ! Vous pouvez maintenant choisir un arrêt que vous voulez utiliser.",
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("GradientTop"), Color("GradientBottom")]), startPoint: .top, endPoint: .bottom)
                
                TabView(selection: $selection) {
                    ForEach(slides.indices) { slideIndex in
                        VStack(alignment: .leading, spacing: 20) {                            
                            Spacer()
                            
                            Text(slides[slideIndex])
                                .font(.system(size: 24, weight: .semibold, design: .default))

                            if slideIndex == slides.count - 1 {
                                Button("Commencer", action: close)
                                .buttonStyle(RoundedButtonStyle(variant: .inversed))
                            } else {
                                Button("Suivant", action: nextSlide)
                                .buttonStyle(RoundedButtonStyle(variant: .inversed))
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .padding(.bottom, 40)
                        .tag(slideIndex)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .padding(geo.safeAreaInsets)
            }
            .ignoresSafeArea()
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: close, label: {
                    Image(systemName: "xmark.circle")
                })
                .accessibility(label: Text("Passer le tutoriel"))
            }
        }
    }

    /// Closes the tutorial.
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
    
    /// Goes to the next slide.
    func nextSlide() {
        withAnimation {
            selection += 1
        }
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TutorialPage()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white)
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
