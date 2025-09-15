//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Scales the property based on DynamicType and the scale factor defined in the style context.
///
/// Define your property:
/// ```
/// @ScaledValue(50) var size
/// ```
@propertyWrapper public struct ScaledValue: DynamicProperty {
    
    public typealias Value = Style.Keys.Number.Value.WrappedValue
    
    @Environment(\.style) private var style
    @ScaledMetric private var scaleDynamicType: CGFloat = 1
    
    private let base: Value

    public init(_ base: Value) {
        self.base = base
    }

    public var wrappedValue: Value {
        base * scaleDynamicType * style.context.scaleFactor
    }

}


// MARK: - Preview

#Preview {
    struct MyView: View {
        
        @ScaledValue(50) var size
        
        var body: some View {
            Rectangle()
                .frame(width: size, height: size)
        }
    }
    
    return MyView()
        .style(scaleFactor: 4)
}
