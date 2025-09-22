//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyleBase
import SwiftUI

extension View {

    public func style(shape keyPath: Style.Keys.Shape.ValueBuilderKeyPath?, shouldClip: Bool = false) -> some View {
        modifier(ShapeKeyModifier(keyPath: keyPath, shouldClip: shouldClip))
    }

}


// MARK: - ShapeKeyModifier

private struct ShapeKeyModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: Style.Keys.Shape.ValueBuilderKeyPath?
    let shouldClip: Bool

    func body(content: Content) -> some View {
        // TODO FB19669133: Have to conditionally construct view, because InsettableShape can not be type erased properly and custom `AnyInsettableShape` crashes when used with `ContainerRelativeShape()`.
        if let keyPath, let shape = style.shape(for: keyPath) {
            if shape == .containerRelative {
                content
                    .modifier(ShapeModifier(shape: .containerRelative, shouldClip: shouldClip))
            } else {
                let shape = shape.shape(with: style)
                content
                    .modifier(ShapeModifier(shape: AnyInsettableShape(shape), shouldClip: shouldClip))
            }
        } else {
            content
                .modifier(ShapeModifier(shape: Rectangle(), shouldClip: shouldClip))
        }
    }
    
}


// MARK: - ShapeModifier

private struct ShapeModifier<SomeInsettableShape: InsettableShape>: ViewModifier {

    let shape: SomeInsettableShape
    let shouldClip: Bool

    func body(content: Content) -> some View {
        content
        #if !os(macOS)
            .contentShape(.hoverEffect, shape)
        #endif
            .containerShape(shape)
            .clipShape(shouldClip ? AnyShape(shape) : AnyShape(Rectangle()))
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
