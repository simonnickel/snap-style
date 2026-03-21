//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

// TODO: Container Element: The Components should define a composition for a container with hierarchies, to simply apply different hierarchies of backgrounds inside a single component. The components container should use the same mechanism. (Is that the same as just assigning the same component again? - kind of, but components container do more)

extension View {

    /// Applies the container.
    /// - Parameters:
    ///   - container: `Properties` to use.
    ///   - state: `InteractionState` the container is in.
    /// - Returns: View with applied Container.
    public func style(
        container: Style.Container.Properties,
        state: Style.Container.InteractionState = .normal
    ) -> some View {
        self
            .styleApply(container: container)
            .modifier(ContainerContextModifier(container: container, state: state))
    }

    private func styleApply(container: Style.Container.Properties) -> some View {
        self
            .modifier(ContainerApplyStyleModifier(container: container))
    }

}


// MARK: - ContainerApplyStyleModifier

private struct ContainerApplyStyleModifier: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.Container.Properties

    func body(content: Content) -> some View {
        let base = Style.Container.Properties.base

        // Call the closures to get the KeyPaths
        let paddingKeyPath: Style.Attribute.Padding.ValueBuilderKeyPath = (container.padding ?? base.padding)?() ?? \.anyContainer
        let compositionKeyPath: Style.Attribute.Composition.ValueBuilderKeyPath = (container.composition ?? base.composition)?() ?? \.anyContainer
        let shapeKeyPath: Style.Attribute.Shape.ValueBuilderKeyPath = (container.shape ?? base.shape)?() ?? \.anyContainer

        content
            .style(padding: paddingKeyPath)
            .style(composition: compositionKeyPath, ignoreSafeAreaEdges: container.ignoresSafeAreaEdges)
            .style(shape: shapeKeyPath)
    }

}


// MARK: - ContainerContextModifier

// TODO iOS26: Remove iOS 18 Variant
private struct ContainerContextModifier: ViewModifier {

    let container: Style.Container.Properties
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

    let container: Style.Container.Properties
    let state: Style.Container.InteractionState

    func body(content: Content) -> some View {
        let stack = style.context.containerStack.appended(container, state: state)
        content
            .style(accent: container.requiresSecondaryAccent ? \.secondary : nil)
            .style(attribute: Style.Context.containerStack, value: stack)
    }

}

private struct ContainerContextModifier18: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.Container.Properties
    let state: Style.Container.InteractionState

    /// Internal copy to apply animation on changes.
    @State private var stateInternal: Style.Container.InteractionState = .normal

    func body(content: Content) -> some View {
        let stack = style.context.containerStack.appended(container, state: stateInternal)
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
