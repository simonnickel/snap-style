//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SwiftUI

extension Style.Attribute.Font.Value.Properties {

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

extension Style.Attribute.Font.Value.Properties {
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

    let propertiesStandard: Style.Attribute.Font.Value.Properties = .init(
        size: 20,
        weight: .heavy,
        width: nil,
        design: nil,
        textStyle: .body
    )
    let propertiesDesign: Style.Attribute.Font.Value.Properties = .init(
        size: 20,
        weight: .heavy,
        width: nil,
        design: .serif,
        textStyle: .body
    )
    let propertiesWidth: Style.Attribute.Font.Value.Properties = .init(
        size: 20,
        weight: .heavy,
        width: .compressed,
        design: nil,
        textStyle: .body
    )

    VStack {
        Text("Standard")
        CompareView(properties: propertiesStandard)
        Text("Design")
        CompareView(properties: propertiesDesign)
        Text("Width")
        CompareView(properties: propertiesWidth)
    }

}

struct CompareView: View {

    let properties: Style.Attribute.Font.Value.Properties

    var body: some View {
        VStack {
            Text("Text SwiftUI")
                .font(properties.font())
                .frame(width: 300, height: 20, alignment: .leading)
            UIKitTextView(text: "Text UIKit", font: properties.uiFont())
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
