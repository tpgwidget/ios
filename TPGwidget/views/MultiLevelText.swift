import SwiftUI

/// Format a source text like `"Abc <small>def</small>"` so that the parts in the `small` tags are smaller.
struct MultiLevelText: View {
    var source: String
    
    var body: some View {
        parts.reduce(
            Text(""),
            { (acc, part) in
                let text = Text(part.text)
                return acc + (part.size == .small ? text.font(.footnote) : text)
            }
        )
    }
    
    private struct Part {
        let text: String
        let size: Size
        
        enum Size { case normal, small }
    }

    private var parts: [Part] {
        var parts = [Part]()
        
        var remainingText = source
        while !remainingText.isEmpty {
            guard let openingTagRange = remainingText.range(of: "<small>") else {
                // No small tag remaining
                parts.append(Part(text: remainingText, size: .normal))
                break
            }
            
            // Add the text before the opening tag
            let beforeOpeningTag = String(remainingText[..<openingTagRange.lowerBound])
            parts.append(Part(text: beforeOpeningTag, size: .normal))
            
            // Go to after the opening tag
            remainingText = String(remainingText[openingTagRange.upperBound...])
            
            // Get the range of the closing tag
            guard let closingTagRange = remainingText.range(of: "</small>") else {
                // No closing tag
                parts.append(Part(text: remainingText, size: .small))
                break
            }
            
            // Add the text before the closing tag
            let beforeClosingTag = String(remainingText[..<closingTagRange.lowerBound])
            parts.append(Part(text: beforeClosingTag, size: .small))
            
            // Remove until the closing tag
            remainingText = String(remainingText[closingTagRange.upperBound...])
        }
        
        return parts
    }
}

struct MultiLevelText_Previews: PreviewProvider {
    static var texts = [
        "<small>Lancy-</small>Pont-Rouge<small>-Gare/Étoile</small>",
        "Annemasse<small>-Parc Montessuit</small>",
        "<small>Cartigny-</small>Moulin-de-Vert",
        "Without <small>closing tag",
    ]
    
    static var previews: some View {
        ForEach(texts, id: \.self) { text in
            MultiLevelText(source: text).previewLayout(.sizeThatFits)
        }
    }
}
