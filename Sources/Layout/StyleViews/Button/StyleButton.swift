//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI


// MARK: - StyleButton

public struct StyleButton<Content>: View where Content : View {

    @Environment(\.style) private var style
    @Environment(\.styleButtonVariant) private var styleButtonVariant
    @Environment(\.enabled) private var enabled

    private let variant: StyleButtonVariant?

    @State private var interactionState: Style.Component.InteractionState = .normal

    private let action: () -> Void
    private let content: () -> Content

    public init(
        _ variant: StyleButtonVariant? = nil,
        _ action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.variant = variant
        self.action = action
        self.content = content
    }

    public var body: some View {
        let variant = self.variant ?? styleButtonVariant
        
        StyleButtonInteractionState($interactionState, action: action) {
            content()
                .style(element: .title)
                .style(
                    component: variant.component,
                    applyContainer: variant.hierarchy,
                    state: enabled ? interactionState : .disabled
                )
        }
        .disabled(!enabled)
    }

}


// MARK: - Preview

#if DEBUG

struct PreviewContent: View {

    let isEnabled: Bool

    var body: some View {
        StyleStack(spacing: \.spacingGroups, alignmentV: .center) {
            StyleButton() { } content: {
                Label("Primary", systemImage: "star")
            }
            
            StyleButton() { } content: {
                Label("Secondary", systemImage: "star")
            }
            .style(buttonVariant: .secondary)
            
            StyleStack(.horizontal, spacing: \.spacingElements) {
                StyleButton(.icon(hierarchy: .primary)) { } content: {
                    Label("Primary", systemImage: "star")
                        .labelStyle(.iconOnly)
                }
                StyleButton(.icon(hierarchy: .secondary)) { } content: {
                    Label("Secondary", systemImage: "star")
                        .labelStyle(.iconOnly)
                }
                StyleButton(.icon(hierarchy: .tertiary)) { } content: {
                    Label("Teriary", systemImage: "star")
                        .labelStyle(.iconOnly)
                }
            }
            
            StyleButton(.component(.metricCard)) { } content: {
                Label("Component: .metricCard", systemImage: "star")
            }
            
            StyleButton(.plain) { } content: {
                Label("Plain", systemImage: "star")
            }
        }
        .style(enabled: isEnabled)
    }
}

#Preview {
    
    @Previewable @State var isEnabled: Bool = true

    StyleScreen {
        PreviewContent(isEnabled: isEnabled)
            .style(component: .contentCard)
        PreviewContent(isEnabled: isEnabled)
            .style(component: .accentCard)

        Toggle(isOn: $isEnabled) {
            Text("enabled")
        }
    }
}

#endif
