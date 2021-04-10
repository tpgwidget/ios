import SwiftUI

/// Shows the tutorial of the app.
struct TutorialPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selection = 0
    
    let slides = [
        "Bienvenue ! TPGwidget permet de créer des raccourcis sur l’écran d’accueil pour vos arrêts de bus ou de tram.",
        "Vous pouvez créer autant de raccourcis que vous voulez : domicile, travail, école…",
        "C’est parti ! Vous pouvez maintenant choisir un arrêt que vous voulez utiliser.",
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .topTrailing) {
                LinearGradient(gradient: Gradient(colors: [Color("GradientTop"), Color("GradientBottom")]), startPoint: .top, endPoint: .bottom)
                
                TabView(selection: $selection) {
                    ForEach(slides.indices) { slideIndex in
                        VStack {
                            Group {
                                Image("welcome\(slideIndex)")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(maxHeight: 350)
                            
                            VStack(alignment: .leading) {
                                Text(slides[slideIndex])
                                    .font(.system(size: 24, weight: .semibold, design: .default))
                                    .padding(.vertical, 8)
                                    .frame(minHeight: 140)

                                if slideIndex == slides.count - 1 {
                                    Button("Commencer", action: close)
                                    .buttonStyle(RoundedButtonStyle(variant: .inversed))
                                } else {
                                    Button("Suivant", action: nextSlide)
                                    .buttonStyle(RoundedButtonStyle(variant: .inversed))
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .padding()
                        .padding(.vertical, 36)
                        .tag(slideIndex)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .padding(geo.safeAreaInsets)
                .padding(.top, 50)
                
                Button(action: close, label: {
                    Image(systemName: "xmark.circle")
                })
                .accentColor(.white)
                .accessibility(label: Text("Passer le tutoriel"))
                .padding()
            }
            .ignoresSafeArea()
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
        ForEach([0, 1, 2], id: \.self) { page in
            TutorialPage(selection: page)
        }
    }
}
