//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleDefinitions
import SwiftUI

extension View {
    
    /// Applies the `Number` as `.listRowInsets()`
    ///
    /// Supports animated change.
    ///
    /// - Parameter valueKeyPath: Number to apply as inset to all edges.
    public func styleListRowInsets(
        _ valueKeyPath: Style.NumberKey.ValueBuilderKeyPath
    ) -> some View {
        modifier(
            ListRowInsetsModifier(
                top: valueKeyPath,
                leading: valueKeyPath,
                bottom: valueKeyPath,
                trailing: valueKeyPath
            )
        )
    }
    
    /// Applies the `Number`s as `.listRowInsets()`
    ///
    /// Supports animated change.
    public func styleListRowInsets(
        top: Style.NumberKey.ValueBuilderKeyPath = \.paddingListRowTop,
        leading: Style.NumberKey.ValueBuilderKeyPath = \.paddingListRowLeading,
        bottom: Style.NumberKey.ValueBuilderKeyPath = \.paddingListRowBottom,
        trailing: Style.NumberKey.ValueBuilderKeyPath = \.paddingListRowTrailing
    ) -> some View {
        modifier(
            ListRowInsetsModifier(
                top: top,
                leading: leading,
                bottom: bottom,
                trailing: trailing
            )
        )
    }

}


// MARK: - Modifier

private struct ListRowInsetsModifier: ViewModifier {

    @Environment(\.style) private var style

    let top: Style.NumberKey.ValueBuilderKeyPath
    let leading: Style.NumberKey.ValueBuilderKeyPath
    let bottom: Style.NumberKey.ValueBuilderKeyPath
    let trailing: Style.NumberKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        let valueTop = style.number(for: top)
        let valueLeading = style.number(for: leading)
        let valueBottom = style.number(for: bottom)
        let valueTrailing = style.number(for: trailing)

        content
            .listRowInsets(
                EdgeInsets(
                    top: valueTop ?? 0,
                    leading: valueLeading ?? 0,
                    bottom: valueBottom ?? 0,
                    trailing: valueTrailing ?? 0
                )
            )
    }

}


// MARK: - Preview

#Preview {
    List {
        Section {
            Label("Star", systemImage: "star")
                .styleListRowInsets()

            Label("Triangle", systemImage: "triangle")
                .styleListRowInsets()

            NavigationLink(value: "None") {
                Label("Rectangle", systemImage: "rectangle")
            }
            .styleListRowInsets()

            Rectangle()
                .styleListRowInsets()
        } header: {
            Text("Custom Inset")
        }

        Section {
            Label("Star", systemImage: "star")
            Label("Rectangle", systemImage: "rectangle")
            Label("Circle", systemImage: "circle")
        } header: {
            Text("System Inset")
        }
    }
    .environment(\.defaultMinListRowHeight, 0)
}
