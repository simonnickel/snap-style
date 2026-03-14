//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    public func style(shape keyPath: Style.Attribute.Shape.ValueBuilderKeyPath?, shouldClip: Bool = false) -> some View {
        modifier(ShapeAttributeModifier(keyPath: keyPath, shouldClip: shouldClip))
    }
    
    /// Convenience shortcut to define a `Shape` for an element via environment.
    public func styleDefine(shape key: Style.Attribute.Shape.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        style(define: Style.Attribute.Shape.self, key: key, for: element)
    }

}


// MARK: - Modifier

package struct ShapeAttributeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: Style.Attribute.Shape.ValueBuilderKeyPath?
    let shouldClip: Bool

    package func body(content: Content) -> some View {
        // FB19669133: Have to conditionally construct view, because InsettableShape can not be type erased properly and custom `AnyInsettableShape` crashes when used with `ContainerRelativeShape()`.
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

#Preview("Animation") {

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

#if DEBUG
extension Style.Component {
    
    static let previewShape: Self = .init(
        "previewShape",
        compositions: { element in
            switch element {
            case .icon: \.interactiveContainer
                default: nil
            }
        },
        shapes: { element in
            switch element {
                case .icon: \.circle
                default: nil
            }
        },
    )
                                         
}
#endif

#Preview("Component") {

    VStack(alignment: .leading, spacing: 15) {
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
            Text("Shape from Component")
        }
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
                .styleDefine(shape: \.containerRelative, for: .icon)
            Text("Shape override")
        }
    }
    .style(component: .previewShape)

}
