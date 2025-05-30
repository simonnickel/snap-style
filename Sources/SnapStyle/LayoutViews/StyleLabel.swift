//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLabel<Content: View>: View {
    
    public typealias Icon = SnapStyle.IconKey.ValueBuilderKeyPath
    
    @Environment(\.style) private var style
    
    private let content: () -> Content
    private let icon: Icon?
    private let systemImage: String?
    
    public init(content: @escaping () -> Content, icon: Icon? = nil, systemImage: String? = nil) {
        self.content = content
        self.icon = icon
        self.systemImage = systemImage
    }
    
    public init(_ title: String, icon: Icon? = nil, systemImage: String? = nil) where Content == Text {
        self.content = { Text(title) }
        self.icon = icon
        self.systemImage = systemImage
    }

    public init(icon: Icon? = nil) where Content == EmptyView {
        self.content = { EmptyView() }
        self.icon = icon
        self.systemImage = nil
    }

    public init(systemImage: String? = nil) where Content == EmptyView {
        self.content = { EmptyView() }
        self.icon = nil
        self.systemImage = systemImage
    }
    
    public var body: some View {
        Label(title: content, icon: {
            if let icon {
                if let iconName = style.value(for: icon)?.wrappedValue {
                    Image(systemName: iconName)
                        .style(element: .icon)
                }
            } else if let systemImage {
                Image(systemName: systemImage)
                    .style(element: .icon)
            } else {
                EmptyView()
            }
        })
    }
    
}


// MARK: - Preview

#Preview {
    VStack {
        
        StyleLabel(content: {
            Text("Content")
        }, icon: \.favorite)
        
        StyleLabel(content: {
            Text("Content")
        })
        
        StyleLabel(icon: \.favorite)
        
        StyleLabel(systemImage: "rectangle")
        
        StyleLabel("Title", icon: \.favorite)
        
    }
}
