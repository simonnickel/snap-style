//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
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

/// Provides a scaled value based on the Key, scaling is influence by DynamicType and the scale factor defined in the style context.
///
/// Define your property:
/// ```
/// @ScaledValue(\.zero) var size
/// ```
@propertyWrapper public struct ScaledNumber: DynamicProperty {
    
    public typealias KeyPath = Style.Keys.Number.ValueBuilderKeyPath
    public typealias Value = Style.Keys.Number.Value.WrappedValue

    @Environment(\.style) private var style
    
    private let keyPath: KeyPath

    public init(_ keyPath: KeyPath) {
        self.keyPath = keyPath
    }

    public var wrappedValue: Value {
        style.number(for: keyPath) ?? 0
    }

}


// MARK: - Preview

extension Style.Keys.Number {
    public var examplePreview: ValueBuilder { .base(.definition(.value(50))) }
}

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
        .styleSetup()
}
