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
            .style(composition: keyPath, layers: [.foreground], scope: .component)
            .listRowBackground(
                Rectangle()
                    .fill(.clear)
                    // Apply with .component here, because this is inside of the listRowBackground.
                    .style(composition: keyPath, layers: [.background, .backgroundOverlay], scope: .component)
                    // TODO FB: (iOS 18.1) Content in .listRowBackground() does not get the environment.
                    .environment(\.style, style)
            )
    }

}


// MARK: - Preview

#Preview {
    
    List {
        Text("Normal List Row")
            .style(listRowBackground: \.interactiveListRow)
            .style(component: .listRow, containerHierarchy: nil, state: .normal)
    }
    
    List {
        Text("Highlighted List Row")
            .style(listRowBackground: \.interactiveListRow)
            .style(component: .listRow, containerHierarchy: nil, state: .highlighted)
    }
    
    List {
        Text("Selected List Row")
            .style(listRowBackground: \.interactiveListRow)
            .style(component: .listRow, containerHierarchy: nil, state: .selected)
    }
    
    List {
        Text("Disabled List Row")
            .style(listRowBackground: \.interactiveListRow)
            .style(component: .listRow, containerHierarchy: nil, state: .disabled)
    }
    
}
