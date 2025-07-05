//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension View {

    public func style(
        padding keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath,
        _ edges: Edge.Set = .all
    ) -> some View {
        modifier(PaddingModifier(keyPath: keyPath, edges: edges))
    }

}


// MARK: - Modifier

private struct PaddingModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: SnapStyle.NumberKey.ValueBuilderKeyPath
    let edges: Edge.Set
    
    func body(content: Content) -> some View {
        if
            let padding = style.number(for: keyPath)
        {
            content
                .padding(edges, padding)
        } else {
            content
        }
    }
    
}
