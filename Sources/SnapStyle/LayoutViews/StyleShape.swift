//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleShape: View { // TODO: Should this be a Shape? or rename to StyleShapeView
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    let shape: SnapStyle.ShapeKey.ShapeDefinition
    let composition: SnapStyle.CompositionKey.ValueBuilderKeyPath
    
    public init(shape: SnapStyle.ShapeKey.ShapeDefinition, composition: SnapStyle.CompositionKey.ValueBuilderKeyPath) {
        self.shape = shape
        self.composition = composition
    }
    
    public var body: some View {
        shape.insettableShape(for: style, in: styleContext)
            .style(composition: composition) // TODO: Fill? Use Composition layer?
    }
    
}

#Preview {
    StyleShape(shape: .capsule, composition: \.separator)
        .frame(width: 200, height: 100)
}
