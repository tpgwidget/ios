import SwiftUI

/// Search bar component.
struct SearchBar: View {
    @Binding var value: String
    @Binding var isActive: Bool
    let placeholder: String
    
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 0) {
                // Text field
                ZStack(alignment: .leading) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                        .offset(x: 4)
                        .allowsHitTesting(false)

                    TextField(placeholder, text: $value, onEditingChanged: { editingChanged in
                        if editingChanged {
                            self.isActive = true
                        }
                    }, onCommit: {})
                    .padding(.horizontal, 30)
                    .padding(.vertical, 8)
                }
                
                // Clear button
                if !value.isEmpty {
                    Button(action: clear, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                    .foregroundColor(.secondary)
                    .padding(8)
                    .accessibility(label: Text("Effacer"))
                }
            }
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            // Cancel button
            if isActive {
                Button("Annuler", action: cancel)
            }
        }
    }
    
    /// Clears the text view.
    func clear() {
        value = ""
    }
    
    // Hide the keyboard and clear the text view
    func cancel() {
        clear()
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        isActive = false
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(value: .constant(""), isActive: .constant(false), placeholder: "Recherche")
            .previewDisplayName("Default")
            .previewLayout(.sizeThatFits)
        
        SearchBar(value: .constant("Hello world"), isActive: .constant(true), placeholder: "Rechercher")
            .previewDisplayName("Active")
            .previewLayout(.sizeThatFits)
    }
}
