//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct StyleLabel<Content: View>: View {
    
    private let content: () -> Content
    // TODO: Icon as Style value
    private let icon: String?
    
    public init(content: @escaping () -> Content, icon: String? = nil) {
        self.content = content
        self.icon = icon
    }
    
    public init(title: String, icon: String? = nil) where Content == Text {
        self.content = { Text(title) }
        self.icon = icon
    }

    public init(icon: String? = nil) where Content == EmptyView {
        self.content = { EmptyView() }
        self.icon = icon
    }
    
    public var body: some View {
        Label(title: content, icon: {
            if let icon {
                Image(systemName: icon)
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
        }, icon: "star")
        
        StyleLabel(content: {
            Text("Content")
        })
        
        StyleLabel(icon: "star")
        
        StyleLabel(title: "Title", icon: "star")
        
    }
}
