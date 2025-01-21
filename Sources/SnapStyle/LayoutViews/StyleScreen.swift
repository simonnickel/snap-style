//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleScreen<Content>: View where Content : View {
    
    @Environment(\.style) private var style
    @Environment(\.styleContext) private var styleContext
    
    private let content: () -> Content
    
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            StyleVStack(spacing: \.spacingSections) {
                content()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .style(padding: \.paddingScreen)
        }
        .style(background: \.screen)
        .styleContextBase()
    }
    
}

#Preview {
    NavigationStack {
        StyleScreen {
            Rectangle()
        }
    }
}
