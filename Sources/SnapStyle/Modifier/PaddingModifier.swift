//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(padding keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath, _ edges: Edge.Set = .all) -> some View {
        self
            .modifier(PaddingModifier(keyPath: keyPath, edges: edges))
    }

}


// MARK: - Modifier

internal struct PaddingModifier: ViewModifier {
    
    @Environment(\.styleDefinition) private var style
    @Environment(\.styleContext) private var styleContext
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        if
            let padding = style.number(for: keyPath, in: styleContext)
        {
            content
                .padding(edges, padding)
        } else {
            content
        }
    }
    
}
