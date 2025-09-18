//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapCore
import SnapStyleBase
import SnapStyleComponents
import SnapStyleDefinitions
import SwiftUI

public typealias StyleButton = Style.Views.Button.ButtonView
extension Style.Views {
    public enum Button {}
}

extension Style.Views.Button {
    
    public struct ButtonView<Content>: View where Content : View {
        
        @Environment(\.style) private var style
        @Environment(\.styleButtonVariant) private var styleButtonVariant
        @Environment(\.enabled) private var enabled
        
        private let variant: Style.Views.Button.Variant?
        
        @State private var interactionState: Style.Component.InteractionState = .normal
        
        private let action: () -> Void
        private let content: () -> Content
        
        public init(
            _ variant: Style.Views.Button.Variant? = nil,
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
    
}


// MARK: - Preview

#if DEBUG

struct PreviewContent: View {

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
    }
}

#Preview {
    
    @Previewable @State var isEnabled: Bool = true

    StyleScreen {
        PreviewContent()
            .style(component: .contentCard)
            .enabled(isEnabled)
        PreviewContent()
            .style(component: .accentCard)
            .enabled(isEnabled)

        Toggle(isOn: $isEnabled) {
            Text("enabled")
        }
    }
}

#endif
