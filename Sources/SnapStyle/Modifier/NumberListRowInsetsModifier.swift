//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func styleListRowInsets(_ valueKeyPath: SnapStyle.NumberKey.ValueBuilderKeyPath) -> some View {
        self
            .modifier(
                ListRowInsetsModifier(
                    top: valueKeyPath,
                    leading: valueKeyPath,
                    bottom: valueKeyPath,
                    trailing: valueKeyPath
                )
            )
    }

    public func styleListRowInsets(
        top: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingListRowTop,
        leading: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingListRowLeading,
        bottom: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingListRowBottom,
        trailing: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingListRowTrailing
    ) -> some View {
        self
            .modifier(
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

internal struct ListRowInsetsModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let top: SnapStyle.NumberKey.ValueBuilderKeyPath
    let leading: SnapStyle.NumberKey.ValueBuilderKeyPath
    let bottom: SnapStyle.NumberKey.ValueBuilderKeyPath
    let trailing: SnapStyle.NumberKey.ValueBuilderKeyPath
    
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
            StyleLabel("Star", systemImage: "star")
                .styleListRowInsets()
            
            StyleLabel("Triangle", systemImage: "triangle")
                .styleListRowInsets()
            
            NavigationLink(value: "None") {
                StyleLabel("Rectangle", systemImage: "rectangle")
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
