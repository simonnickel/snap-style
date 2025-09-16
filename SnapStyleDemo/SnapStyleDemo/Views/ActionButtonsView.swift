//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct ActionButtonsView: View {

    enum Element {
        case icon, subtitle
    }

    let elements: [Element]
    var showIcon: Bool { elements.contains(.icon) }
    var showSubtitle: Bool { elements.contains(.subtitle) }

    internal init(elements: [Element] = []) {
        self.elements = elements
    }

    var body: some View {
        StyleStack(.horizontal) {
            StyleButton(.secondary) { } content: {
                content(title: "Secondary", subtitle: showSubtitle ? "Subtitle" : nil)
            }
            
            StyleSpacer(min: \.spacingElements)
            
            StyleButton(.primary) { } content: {
                content(title: "Primary", subtitle: showSubtitle ? "Subtitle" : nil)
            }
        }
    }
    
    private func content(title: String, subtitle: String?) -> some View {
        StyleStack(isStretching: false) {
            StyleLabel(icon: showIcon ? \.favorite : nil) {
                StyleStack(isStretching: false) {
                    Text(title)
                    if let subtitle {
                        Text(subtitle)
                            .style(hierarchy: .secondary)
                    }
                }
            }
        }
    }
}


// MARK: - Preview

#Preview {
    ActionButtonsView()
    ActionButtonsView(elements: [.icon, .subtitle])
}
