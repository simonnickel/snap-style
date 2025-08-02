//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleDefinitions
import SwiftUI

extension View {

    /// Applies the `Number` as `.listSectionSpacing()`
    ///
    /// - Parameter valueKeyPath: Number to apply as spacing.
    public func styleListSectionSpacing(
        _ valueKeyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    ) -> some View {
        modifier(
            ListSectionSpacingModifier(spacing: valueKeyPath)
        )
    }

}


// MARK: - Modifier

private struct ListSectionSpacingModifier: ViewModifier {

    @Environment(\.style) private var style

    let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        let value = style.number(for: spacing)

#if !os(macOS)
        // TODO FB: Modifier with value has no inert variant and can not be combined with `.default`.
        if let value {
            content
                .listSectionSpacing(value)
        } else {
            content
                .listSectionSpacing(.default)
        }
#else
        content
#endif

    }

}


// MARK: - Preview

#Preview {
    List {
        Section {
            Label("Star", systemImage: "star")
            Label("Rectangle", systemImage: "rectangle")
            Label("Circle", systemImage: "circle")
        } header: {
            Text("System Inset")
        }

        Section {
            Label("Star", systemImage: "star")
            Label("Rectangle", systemImage: "rectangle")
            Label("Circle", systemImage: "circle")
        } header: {
            Text("System Inset")
        }
    }
    .styleListSectionSpacing(\.spacingSections)
}
