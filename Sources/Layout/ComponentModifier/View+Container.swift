//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {

    /// Applies the container.
    /// - Parameters:
    ///   - container: `ContainerDefinition` to use.
    ///   - state: `InteractionState` the container is in.
    /// - Returns: View with applied Container.
    public func style(
        container: Style.ContainerDefinition,
        state: Style.Container.InteractionState = .normal
    ) -> some View {
        self
            .style(container: container)
            .modifier(ContainerContextModifier(container: container, state: state))
    }

    private func style(container: Style.ContainerDefinition) -> some View {
        self
            .modifier(ContainerApplyStyleModifier(container: container))
    }

}


// MARK: - ContainerApplyStyleModifier

private struct ContainerApplyStyleModifier: ViewModifier {

    @Environment(\.style) private var style

    let container: Style.ContainerDefinition

    func body(content: Content) -> some View {
        let base = Style.ContainerDefinition.base

        let padding = container.padding ?? base.padding
        let compositionKeyPath = container.compositions ?? base.compositions ?? \.anyContainer
        let shapeKeyPath = container.shapes ?? base.shapes

        content
            .style(padding: padding?.leading, .leading)
            .style(padding: padding?.top, .top)
            .style(padding: padding?.trailing, .trailing)
            .style(padding: padding?.bottom, .bottom)
            .style(composition: compositionKeyPath, ignoreSafeAreaEdges: container.ignoresSafeAreaEdges)
            .style(shape: shapeKeyPath)
    }

}


// MARK: - ContainerContextModifier

// TODO iOS26: Remove iOS 18 Variant
private struct ContainerContextModifier: ViewModifier {

    let container: Style.ContainerDefinition
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

    let container: Style.ContainerDefinition
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

    let container: Style.ContainerDefinition
    let state: Style.Container.InteractionState

    /// Internal copy to apply animation on changes.
    @State private var stateInternal: Style.Container.InteractionState = .normal

    func body(content: Content) -> some View {
        let stack = style.context.containerStack.appended(container, state: stateInternal)
        content
            .style(attribute: Style.Context.containerStack, value: stack)
            .onChange(of: state, initial: true) { oldValue, newValue in
                // TODO FB: (iOS 18) Need to delay to prevent from SwiftUI skipping animations. Happens e.g. when pushing a screen on a NavigationStack.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    withAnimation {
                        stateInternal = newValue
                    }
                }
            }
    }

}
