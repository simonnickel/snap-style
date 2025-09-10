//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI

extension Style.Keys.Font.Value.Definition {

    public func font(size sizeOverride: Double? = nil) -> Font {
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

extension Style.Keys.Font.Value.Definition {
    public func uiFont(size sizeOverride: Double? = nil) -> UIFont {
        let sizeToUse = sizeOverride ?? size
        let font: UIFont = if let width {
            .systemFont(ofSize: sizeToUse, weight: weight.uiFontWeight, width: width.uiFontWidth)
        } else {
            .systemFont(ofSize: sizeToUse, weight: weight.uiFontWeight)
        }

        if let design, let descriptor = font.fontDescriptor.withDesign(design.uiFontDesign) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return font
        }

    }
}
#endif


// MARK: - Preview

#if DEBUG && canImport(UIKit)

#Preview {

    let definitionStandard: Style.Keys.Font.Value.Definition = .init(
        size: 20,
        weight: .heavy,
        width: nil,
        design: nil,
        textStyle: .body
    )
    let definitionDesign: Style.Keys.Font.Value.Definition = .init(
        size: 20,
        weight: .heavy,
        width: nil,
        design: .serif,
        textStyle: .body
    )
    let definitionWidth: Style.Keys.Font.Value.Definition = .init(
        size: 20,
        weight: .heavy,
        width: .compressed,
        design: nil,
        textStyle: .body
    )

    VStack {
        Text("Standard")
        CompareView(definition: definitionStandard)
        Text("Design")
        CompareView(definition: definitionDesign)
        Text("Width")
        CompareView(definition: definitionWidth)
    }

}

struct CompareView: View {

    let definition: Style.Keys.Font.Value.Definition

    var body: some View {
        VStack {
            Text("Text SwiftUI")
                .font(definition.font())
                .frame(width: 300, height: 20, alignment: .leading)
            UIKitTextView(text: "Text UIKit", font: definition.uiFont())
                .frame(width: 300, height: 20, alignment: .leading)
        }
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
