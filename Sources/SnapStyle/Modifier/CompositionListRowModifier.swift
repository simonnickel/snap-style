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
    @available(*, deprecated, message: "`style(listRowBackground:)` is not recommended to use. Has issues with environment and does not properly animate component state changes. (iOS 18) - Should use `.styleListRowInsets(.zero)` instead and `.style(component: .listRow)`")
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
            .listRowBackground(
                Rectangle()
                    .fill(.clear)
                    .style(composition: keyPath, layers: [.background, .backgroundOverlay])
                    // TODO FB: (iOS 18.4) Content in .listRowBackground() does not get the environment.
                    .environment(\.style, style)
            )
    }

}


// MARK: - Preview

#Preview {
    
    List {
        Text("Normal List Row")
            .style(listRowBackground: \.listRow)
            .style(component: .listRow, applyContainer: nil, state: .normal)
    }
    
    List {
        Text("Highlighted List Row")
            .style(listRowBackground: \.listRow)
            .style(component: .listRow, applyContainer: nil, state: .highlighted)
    }
    
    List {
        Text("Selected List Row")
            .style(listRowBackground: \.listRow)
            .style(component: .listRow, applyContainer: nil, state: .selected)
    }
    
    List {
        Text("Disabled List Row")
            .style(listRowBackground: \.listRow)
            .style(component: .listRow, applyContainer: nil, state: .disabled)
    }
    
}
