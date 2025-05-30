//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleIcon: View {
    
    @Environment(\.style) private var style
    
    private let icon: Definition
    
    public init(_ icon: Definition) {
        self.icon = icon
    }
    
    public init(_ icon: SnapStyle.IconKey.ValueBuilderKeyPath) {
        self.icon = .icon(icon)
    }
    
    public init(_ icon: String) {
        self.icon = .system(icon)
    }
    
    public var body: some View {
        
        switch icon {
            case .icon(let keyPath):
                if let iconName = style.value(for: keyPath)?.wrappedValue {
                    Image(systemName: iconName)
                } else {
                    Image(systemName: "questionmark.diamond")
                }
            case .system(let name):
                AnyView(Image(systemName: name))
        }
        
    }
}

extension StyleIcon {
    public enum Definition {
        case icon(SnapStyle.IconKey.ValueBuilderKeyPath)
        case system(String)
        
        /// Convenience init to create a definition if either a KeyPath or String might be available.
        init?(icon: SnapStyle.IconKey.ValueBuilderKeyPath?, systemImage: String?) {
            if let icon {
                self = .icon(icon)
            } else if let systemImage {
                self = .system(systemImage)
            } else {
                return nil
            }
        }
    }
}


// MARK: - Preview

#Preview {
    StyleIcon(\.favorite)
}
