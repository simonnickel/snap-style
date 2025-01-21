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
    let surface: SnapStyle.SurfaceKey.ValueBuilderKeyPath
    
    public init(shape: SnapStyle.ShapeKey.ShapeDefinition, surface: SnapStyle.SurfaceKey.ValueBuilderKeyPath) {
        self.shape = shape
        self.surface = surface
    }
    
    public var body: some View {
        shape.insettableShape(for: style, in: styleContext)
            .style(surface: surface) // TODO: Fill? Use Surface layer?
    }
    
}

#Preview {
    StyleShape(shape: .capsule, surface: \.separator)
        .frame(width: 200, height: 100)
}
