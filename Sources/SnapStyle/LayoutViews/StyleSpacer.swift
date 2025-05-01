//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleSpacer: View {
    
    @Environment(\.style) var style
    
    private let minLength: SnapStyle.NumberKey.ValueBuilderKeyPath
    
    public init(minLength: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingElements) {
        self.minLength = minLength
    }
    
    public var body: some View {
        let value = style.number(for: minLength)
        Spacer(minLength: CGFloat(value ?? 0))
    }
    
}


// MARK: - Preview

#Preview {
    HStack {
        Rectangle()
        StyleSpacer(minLength: \.spacingElements)
        Rectangle()
    }
}
