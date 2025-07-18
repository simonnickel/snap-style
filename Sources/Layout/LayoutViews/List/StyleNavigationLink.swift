//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

/// A NavigationLink as `.listRow` component which delays `InteractionState` after it no longer presents it's value.
/// Necessary to allow the selection highlight to show through after the destination got dismissed.
internal struct StyleNavigationLink<SelectionValue: Hashable, Content: View>: View {
    
    @Environment(\.style) var style
    
    let value: SelectionValue
    let interactionState: SnapStyle.Component.InteractionState
    let isPresented: Bool
    let content: () -> Content
    
    @State private var isHighlighted: Bool = false
    
    private var delay: Double {
        style.number(for: \.animationInteractionHighlightDuration) ?? 0
    }
    
    var body: some View {
        NavigationLink(value: value) {
            content()
        }
        .style(component: .listRow, state: isHighlighted ? .highlighted : interactionState)
        .onChange(of: isPresented, initial: true) { oldValue, newValue in
            if oldValue && !newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation {
                        isHighlighted = false
                    }
                }
            } else {
                isHighlighted = newValue
            }
        }
    }
}
