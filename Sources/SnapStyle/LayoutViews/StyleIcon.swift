//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleIcon: View {
    
    @Environment(\.style) private var style
    
    private let icon: SnapStyle.IconKey.ValueBuilderKeyPath
    
    public init(_ icon: SnapStyle.IconKey.ValueBuilderKeyPath) {
        self.icon = icon
    }
    
    public var body: some View {
        if let iconName = style.value(for: icon)?.wrappedValue {
            Image(systemName: iconName)
        } else {
            Image(systemName: "questionmark.diamond")
        }
    }
}


// MARK: - Preview

#Preview {
    StyleIcon(\.favorite)
}
