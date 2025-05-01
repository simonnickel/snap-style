//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleShapeView: View {
    
    @Environment(\.style) private var style
    
    let shape: SnapStyle.ShapeKey.ShapeDefinition
    let surface: SnapStyle.SurfaceKey.ValueBuilderKeyPath
    
    public init(shape: SnapStyle.ShapeKey.ShapeDefinition, surface: SnapStyle.SurfaceKey.ValueBuilderKeyPath) {
        self.shape = shape
        self.surface = surface
    }
    
    public var body: some View {
        let value = style.surface(for: surface)
        shape.insettableShape(for: style)
            .fill(value ?? AnyShapeStyle(.clear))
    }
    
}

#Preview {
    StyleShapeView(shape: .capsule, surface: \.accent)
        .frame(width: 200, height: 100)
}
