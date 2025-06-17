//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI

extension SnapStyle.FontKey.Value.Definition {

    public func font(size sizeOverride: Double? = nil, design: Font.Design? = nil) -> Font {
        let sizeToUse = sizeOverride ?? size

        var font: Font = .system(size: sizeToUse, weight: weight, design: design)
        if let width {
            font = font.width(width)
        }

        return font
    }
}


// MARK: - UIFont

#if canImport(UIKit)

import UIKit

extension SnapStyle.FontKey.Value.Definition {
    public func uiFont(size sizeOverride: Double? = nil, design: Font.Design? = nil) -> UIFont {
        let sizeToUse = sizeOverride ?? size
        let font: UIFont = if let width {
            .systemFont(ofSize: sizeToUse, weight: weight.uiFontWeight, width: width.uiFontWidth)
        } else {
            .systemFont(ofSize: sizeToUse, weight: weight.uiFontWeight)
        }

        return font
    }
}
#endif


// MARK: - Preview

#if DEBUG && canImport(UIKit)

#Preview {

    let fontDefinition: SnapStyle.FontKey.Value.Definition = .init(
        size: 20,
        weight: .heavy,
        width: .condensed,
        design: .rounded,
        textStyle: .body
    )

    VStack {
        Text("Text SwiftUI")
            .font(fontDefinition.font())
            .frame(width: 300, height: 20, alignment: .leading)
        UIKitTextView(text: "Text UIKit", font: fontDefinition.uiFont())
            .frame(width: 300, height: 20, alignment: .leading)
    }

}

struct UIKitTextView: UIViewRepresentable {

    let text: String
    let font: UIFont

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font

        return label
    }

    func updateUIView(_ activityIndicator: UILabel, context: Context) { }
}

#endif
