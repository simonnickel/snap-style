//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleDefinitions
import SwiftUI

public struct StyleSpacer: View {

    @Environment(\.style) var style

    private let minLength: SnapStyle.NumberKey.ValueBuilderKeyPath?
    private let length: SnapStyle.NumberKey.ValueBuilderKeyPath?
    
    public init(_ length: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingElements) {
        self.minLength = nil
        self.length = length
    }

    public init(min: SnapStyle.NumberKey.ValueBuilderKeyPath) {
        self.minLength = min
        self.length = nil
    }

    public var body: some View {
        let valueMin: CGFloat? = if let value = style.number(for: minLength) { CGFloat(value) } else { nil }
        let valueLength: CGFloat? = if let value = style.number(for: length) { CGFloat(value) } else { nil }
        Spacer(minLength: valueMin)
            .frame(width: valueLength ?? nil)
    }

}


// MARK: - Preview

#Preview {
    VStack {
        HStack {
            Rectangle()
            StyleSpacer(\.spacingElements)
            Rectangle()
        }
        
        HStack {
            Rectangle()
            StyleSpacer(\.spacingElements)
            Rectangle()
        }
        .style(scaleFactor: 5)
        
        HStack {
            Rectangle()
            StyleSpacer(min: \.spacingElements)
            Rectangle()
        }
        
        HStack {
            Rectangle()
                .frame(width: 10)
            StyleSpacer(min: \.spacingElements)
            Rectangle()
        }

        HStack {
            Rectangle()
            StyleSpacer(min: \.spacingElements)
            Rectangle()
        }
        .style(scaleFactor: 5)
    }
}
