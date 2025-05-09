//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {
    
    /// Applies the background layer of the given `CompositionKey` as listRowBackground.
    /// - Parameter listRowBackground: The `CompositionKey` to use.
    /// - Returns: A modified view.
    public func style(
        listRowBackground keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath
    ) -> some View {
        self
            .modifier(CompositionListRowModifier(keyPath: keyPath))
    }
    
}


// MARK: - Modifier

internal struct CompositionListRowModifier: ViewModifier {

    @Environment(\.style) private var style

    let keyPath: SnapStyle.CompositionKey.ValueBuilderKeyPath

    func body(content: Content) -> some View {
        content
            .style(composition: keyPath, layer: .foreground)
            .listRowBackground(
                Rectangle()
                    .fill(.clear)
                    .style(composition: keyPath)
            )
    }

}


// MARK: - Preview

#Preview {
    
    // Sets component state on outer List, to use listRowBackground without an interfering component.
    
    List {
        Text("Normal List Row")
            .style(listRowBackground: \.interactiveListRow)
    }
    .style(component: .list, state: .normal)
    
    List {
        Text("Highlighted List Row")
            .style(listRowBackground: \.interactiveListRow)
    }
    .style(component: .list, state: .highlighted)
    
    List {
        Text("Selected List Row")
            .style(listRowBackground: \.interactiveListRow)
    }
    .style(component: .list, state: .selected)
    
    List {
        Text("Disabled List Row")
            .style(listRowBackground: \.interactiveListRow)
    }
    .style(component: .list, state: .disabled)
    
}
