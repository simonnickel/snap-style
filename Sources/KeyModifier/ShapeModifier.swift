//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(shape keyPath: SnapStyle.ShapeKey.ValueBuilderKeyPath?) -> some View {
        modifier(ShapeModifier(keyPath: keyPath))
    }

}


// MARK: - Modifier

private struct ShapeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.ShapeKey.ValueBuilderKeyPath?

    var shape: InsettableShape {
        if let keyPath, let shape = style.shape(for: keyPath) {
            if shape == .containerRelative {
                .containerRelative
            } else {
                shape.shape(with: style)
            }
        } else {
            Rectangle()
        }
    }

    func body(content: Content) -> some View {
        AnyView(
            content
            #if !os(macOS)
                .contentShape(.hoverEffect, shape)
            #endif
                .containerShape(shape)
        )
    }
    
}


// MARK: - Preview

#Preview {

    @Previewable @State var isActive: Bool = true

    VStack {
        Text("Card Shape, no component")
        VStack {
            Text("Card Shape")
        }
        .padding(20)
        .style(background: \.contentBackground)
        .style(shape: isActive ? \.containerCard : nil)

        VStack {
            Text("Container Relative Shape")
        }
        .padding(20)
        .style(background: \.contentBackground)
        .style(shape: isActive ? \.containerRelative : nil)
    }
    .padding(10)
    .style(background: \.accentBackground)
    .style(shape: \.containerCard)

    Button {
        withAnimation(.smooth) {
            isActive.toggle()
        }
    } label: {
        Text("Toggle")
    }

}
