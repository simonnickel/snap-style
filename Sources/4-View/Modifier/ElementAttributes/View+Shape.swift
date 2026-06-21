//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapFoundation
import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    public func style(shape keyPath: Style.Attribute.Shape.ValueBuilderKeyPath?) -> some View {
        modifier(ShapeAttributeModifier(keyPath: keyPath))
    }
    
    /// Convenience shortcut to define a `Shape` for an element via environment.
    public func style(
        define element: Style.Element.ElementType,
        shape key: Style.Attribute.Shape.ValueBuilderKeyPath?,
        shouldClear: Bool = false,
    ) -> some View {
        style(
            define: element,
            key: key,
            shouldClear: shouldClear,
        )
    }

}


// MARK: - Modifier

package struct ShapeAttributeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: Style.Attribute.Shape.ValueBuilderKeyPath?

    package func body(content: Content) -> some View {
        // FB19669133: Have to conditionally construct view, because InsettableShape can not be type erased properly and custom `AnyInsettableShape` crashes when used with `ContainerRelativeShape()`.
        // When this causes animation issues: Make sure to only animate between definitions in the same view tree, e.g. between custom shapes.
        if let keyPath, let shape = style.shape(for: keyPath) {
            if shape == .containerRelative {
                content
                    .modifier(ShapeModifier(shape: .containerRelative))
            } else {
                let shape = shape.shape(with: style)
                content
                    .modifier(ShapeModifier(shape: AnyInsettableShape(shape)))
            }
        } else {
            content
        }
    }
    
}


// MARK: - ShapeModifier

/// SwiftUI does not animate shape changes.
private struct ShapeModifier<SomeInsettableShape: InsettableShape>: ViewModifier {

    let shape: SomeInsettableShape

    func body(content: Content) -> some View {
        content
            .contentShape(shape)
            .clipShape(shape)
            .containerShape(shape)
    }
    
}


// MARK: - Preview

#Preview {
    StyleShapeModifierExample()
}

package struct StyleShapeModifierExample: View {

    @State private var override: Bool = true

    package init() {}

    package var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "star")
                    .style(element: .icon)
                Text("Shape from Component")
                    .style(element: .label)
            }
            HStack {
                Image(systemName: "star")
                    .style(element: .icon)
                    .modifier(ShapeModifier(shape: override ? AnyInsettableShape(Rectangle()) : AnyInsettableShape(Circle())))
                    .style(define: .icon, shape: override ? \.rectangle : nil) // Does not animate!
                Toggle(isOn: $override.animation(.bouncy.delay(2))) {
                    Text("Define override")
                        .style(element: .label)
                }
            }
        }
        .style(component: exampleComponent)
    }

    let exampleComponent: Style.Component = .init(
        "exampleComponent",
        container: .contentCard,
        compositions: { element in
            switch element {
            case .icon: \.interactiveContainer
                default: nil
            }
        },
        paddings: { element in
            switch element {
            case .icon: \.containerCard
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
