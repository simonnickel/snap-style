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
        _ valueKeyPath: Style.Keys.Number.ValueBuilderKeyPath
    ) -> some View {
        modifier(
            ListSectionSpacingModifier(spacing: valueKeyPath)
        )
    }

}


// MARK: - Modifier

private struct ListSectionSpacingModifier: ViewModifier {

    @Environment(\.style) private var style

    let spacing: Style.Keys.Number.ValueBuilderKeyPath

    func body(content: Content) -> some View {
#if os(macOS)
        // `.listSectionSpacing()` is not available on macOS.
        content
#else
        let value = style.number(for: spacing)
        let spacing: ListSectionSpacing = if let value {
            .custom(value)
        } else {
            .default
        }

        content.listSectionSpacing(spacing)
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
