//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI
import SnapStyleBase

extension View {

    // TODO: Inert value (nil or default) should not set default, but current value from context.
    public func style(scaleFactor: Style.Context.ScaleFactor? = nil) -> some View {
        self
            .style(attribute: Style.Context.scaleFactor, value: scaleFactor ?? Style.Context.scaleFactorDefault)
    }

}


// MARK: - Preview

#if DEBUG

extension Style.Attribute.Number {
    public var examplePreview: ValueBuilder { .base(.value(.scaled(50))) }
}

#endif

#Preview {
    struct MyView: View {
        
        @ScaledValue(50) var width
        @ScaledNumber(\.examplePreview) var height
        
        var body: some View {
            Rectangle()
                .frame(width: width, height: height)
        }
    }
    
    return MyView()
        .style(scaleFactor: 2)
        .styleSetupLazy()
}
