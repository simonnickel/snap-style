//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {
    
    /// Applies the given container.
    public func style(
        container: Style.Container.Properties?,
        state: Style.Container.InteractionState = .normal,
    ) -> some View {
        self
            .modifier(ContainerApplyStyleModifier(container: container))
            .modifier(ContainerContextModifier(container: container, state: state))
    }
    
}
 

// MARK: - FromComponentModifier

extension View {
    
    /// Applies the container defined by the component.
    public func styleContainer(
        state: Style.Container.InteractionState = .normal,
    ) -> some View {
        self.modifier(ContainerFromComponentModifier(state: state))
    }
    
}

/// Applies the container defined by the component.
private struct ContainerFromComponentModifier: ViewModifier {
    
    @Environment(\.style) private var style

    let state: Style.Container.InteractionState
    
    func body(content: Content) -> some View {
        content
            .style(container: style.context.component.container, state: state)
    }
}


// MARK: - ApplyStyleModifier

/// Applies the container to the view.
private struct ContainerApplyStyleModifier: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.Container.Properties?

    func body(content: Content) -> some View {
        let paddingKeyPath: Style.Attribute.Padding.ValueBuilderKeyPath? = container?.padding?()
        let compositionKeyPath: Style.Attribute.Composition.ValueBuilderKeyPath? = container?.composition?()
        let shapeKeyPath: Style.Attribute.Shape.ValueBuilderKeyPath? = container?.shape?()

        let composition = style.composition(for: compositionKeyPath)
        
        content
            .style(padding: paddingKeyPath)
            .style(border: composition?.surfaceKey(for: .border), shape: shapeKeyPath, width: container?.border?())
            .style(accent: (container?.requiresSecondaryAccent ?? false) ? .secondary : nil)
            .style(composition: compositionKeyPath, ignoreSafeAreaEdges: container?.ignoresSafeAreaEdges ?? [])
            .style(shape: shapeKeyPath)
    }

}


// MARK: - ContextModifier

// TODO iOS26: Remove iOS 18 Variant
/// Updates the context with container definition.
private struct ContainerContextModifier: ViewModifier {

    let container: Style.Container.Properties?
    let state: Style.Container.InteractionState

    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .modifier(ContainerContextModifier26(container: container, state: state))
        } else {
            content
                .modifier(ContainerContextModifier18(container: container, state: state))
        }
    }
}

private struct ContainerContextModifier26: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.Container.Properties?
    let state: Style.Container.InteractionState

    func body(content: Content) -> some View {
        let stack = if let container {
            style.context.containerStack.appended(container, state: state)
        } else {
            style.context.containerStack
        }
        content
            .style(attribute: Style.Context.containerStack, value: stack)
    }

}

private struct ContainerContextModifier18: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.Container.Properties?
    let state: Style.Container.InteractionState

    /// Internal copy to apply animation on changes.
    @State private var stateInternal: Style.Container.InteractionState = .normal

    func body(content: Content) -> some View {
        let stack = if let container {
            style.context.containerStack.appended(container, state: stateInternal)
        } else {
            style.context.containerStack
        }
        content
            .style(attribute: Style.Context.containerStack, value: stack)
            .onChange(of: state, initial: true) { oldValue, newValue in
                // TODO FB: (iOS 18) Need to delay to prevent SwiftUI from skipping animations. Happens e.g. when pushing a screen on a NavigationStack.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation {
                        stateInternal = newValue
                    }
                }
            }
    }

}


// MARK: - Preview

#Preview {
    StyleContainerModifierExample()
}

package struct StyleContainerModifierExample: View {

    package init() {}

    package var body: some View {
        StyleScreen {

            containerStack(component: .contentCard)
            containerStack(component: .accentCard)
            containerStack(component: .infoCard)
            containerStack(component: .metricCard)

        }
    }

    @ViewBuilder
    private func containerStack(component: Style.Component) -> some View {
        StyleStack(spacing: \.spacingElements) {
            Text("Stack of .\(component.description)")
                .style(element: .title)
            StyleStack(spacing: \.spacingElements) {
                Text("Level 2")
                    .style(element: .title)
                StyleStack(spacing: \.spacingElements) {
                    Text("Level 3")
                        .style(element: .title)
                }
                .styleContainer()
            }
            .styleContainer()
        }
        .styleContainer()
        .style(component: component, applyContainer: false)
    }

}
