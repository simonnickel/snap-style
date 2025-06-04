//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

// StyleListRow aligns the icons by their center and the content on the leading edge.
// Icon might have different width though, so StyleList and StyleListRow store the largest width and applies them to all icons.

// Therefore the icon sizes are reported up the hierarchy via the `ListIconWidthPreferenceKey`.
// The StyleList provides the highest value via Environment to apply on the icons.


// MARK: - Synchronisation

extension View {
    
    /// Enables icon width synchronisation with the other rows in the same `StyleList`. Reports the own icon width and applies the highest value to the frame.
    /// Needs to be applied on the icon of each list row.
    func listIconWidthSynchronized() -> some View {
        self.modifier(ListIconWidthSynchronisationModifier())
    }
    
}

private struct ListIconWidthSynchronisationModifier: ViewModifier {
    
    @Environment(\.listIconWidth) private var listIconWidth

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geo in
                Color
                    .clear
                    .preference(key: ListIconWidthPreferenceKey.self, value: geo.size.width)
            })
            .frame(width: listIconWidth, alignment: .center)
    }
    
}


// MARK: - Inset

extension View {
    
    func insetListContent() -> some View {
        modifier(ListContentInsetModifier())
    }
}

private struct ListContentInsetModifier: ViewModifier {
    
    @Environment(\.listIconWidth) private var listIconWidth
    
    func body(content: Content) -> some View {
        content
            .padding(.leading, listIconWidth)
            .style(padding: \.spacingListRowLeading, .leading)
    }
    
}


// MARK: - Scope

extension View {
    
    /// Defines the scope of icon width synchronisation. Stores the highest value and provides it via Environment.
    /// Needs to be defined on the `List`.
    func listIconWidthScope() -> some View {
        self.modifier(ListIconWidthScopeModifier())
    }
    
}

private struct ListIconWidthScopeModifier: ViewModifier {
    
    @State private var listIconWidth: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .environment(\.listIconWidth, listIconWidth)
            .onPreferenceChange(ListIconWidthPreferenceKey.self) { value in
                listIconWidth = value
            }
    }
    
}


// MARK: - PreferenceKey

/// Holds the largest width of an icon defined in the scope.
struct ListIconWidthPreferenceKey: PreferenceKey {
    static var defaultValue: Double { 0 }

    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = max(value, nextValue())
    }
}


// MARK: - Environment

extension EnvironmentValues {
    
    /// The largest width of an icon in the scope.
    @Entry var listIconWidth: CGFloat = 0

}
