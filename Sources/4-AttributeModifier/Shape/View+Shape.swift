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

}


// MARK: - Shape for Element

extension View {

    public func styleApplyShape(for element: Style.Element.ElementType) -> some View {
        let keyPath = Style.Attribute.Shape.environmentKeyPath(for: element)
        return modifier(ShapeFromEnvironmentModifier(keyPath: keyPath))
    }

    @ViewBuilder
    public func styleSetup(shape key: Style.Attribute.Shape.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        if let key {
            let keyPath = Style.Attribute.Shape.environmentKeyPath(for: element)
            environment(keyPath, key)
        } else {
            self
        }
    }

    @ViewBuilder
    package func setupShape(for component: Style.Component) -> some View {
        self
            .styleSetup(shape: component.shapes?(.any), for: .any)
            .styleSetup(shape: component.shapes?(.title), for: .title)
            .styleSetup(shape: component.shapes?(.label), for: .label)
            .styleSetup(shape: component.shapes?(.icon), for: .icon)
            .styleSetup(shape: component.shapes?(.value), for: .value)
            .styleSetup(shape: component.shapes?(.accessory), for: .accessory)
            .styleSetup(shape: component.shapes?(.separator), for: .separator)
            .styleSetup(shape: component.shapes?(.footnote), for: .footnote)
    }

}


// MARK: - Modifier

private struct ShapeFromEnvironmentModifier: ViewModifier {

    @Environment(\.self) private var environment
    @Environment(\.style) private var style

    let keyPath: KeyPath<EnvironmentValues, Style.Attribute.Shape.ValueBuilderKeyPath>

    func body(content: Content) -> some View {
        let key = environment[keyPath: keyPath]
        content
            .modifier(ShapeAttributeModifier(keyPath: key, shouldClip: false)) // TODO: Should clip?
    }

}

private struct ShapeAttributeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: Style.Attribute.Shape.ValueBuilderKeyPath?
    let shouldClip: Bool

    func body(content: Content) -> some View {
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

#if DEBUG
extension Style.Component {
    
    public static let preview: Self = .init(
        "preview",
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

    VStack {
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
            Text("With shape from Component")
        }
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
                .styleSetup(shape: \.containerRelative, for: .icon)
            Text("With custom override")
        }
    }
    .padding(10)
    .style(component: .preview)

}
